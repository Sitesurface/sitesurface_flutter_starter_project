import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../cache/prefs_constant.dart';
import '../../../cache/shared_preferences.dart';
import '../../../main.dart';
import '../../../util/bot_toast/bot_toast_functions.dart';
import '../view/login_screen.dart';
import 'auth_state.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc()
      : super(const AuthState(
          error: false,
          isAuthenticated: false,
          resendText: '',
          canResendOtp: false,
          requiresRecentLogin: false,
        ));

  final SharedPreferences _prefs = Pref.instance.pref;
  String? _verificationId;

  // * Email Login

  Future<void> emailLogin(
      {required String emailAddress, required String password}) async {
    try {
      showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user != null) {
        await saveToken();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await createUserEmail(emailAddress: emailAddress, password: password);
      } else {
        showError(e.code);
      }
    } catch (e) {
      debugPrint(e.toString());
      showError('something-went-wrong');
    } finally {
      closeLoading();
    }
  }

  Future<void> createUserEmail(
      {required String emailAddress, required String password}) async {
    try {
      showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user != null) {
        await saveToken();
      }
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    } catch (e) {
      debugPrint(e.toString());
      showError('something-went-wrong');
    } finally {
      closeLoading();
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      showLoading();
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(error: true, errorCode: "something-went-wrong"));
      emit(state.copyWith(error: false, errorCode: null));
    } finally {
      closeLoading();
    }
  }

  Future<void> changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      showLoading();
      await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await emailLogin(emailAddress: email, password: oldPassword);
        await changePassword(email, oldPassword, newPassword);
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(error: true, errorCode: "something-went-wrong"));
      emit(state.copyWith(error: false, errorCode: null));
    } finally {
      closeLoading();
    }
  }

  // * Phone number Login

  Future<void> phoneNumberSignIn(
    String phoneNumber,
  ) async {
    try {
      emit(state.copyWith(phoneNumber: phoneNumber));
      startTimeout();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.replaceAll(" ", ""),
        verificationCompleted: (PhoneAuthCredential credential) async {
          emit(state.copyWith(otp: credential.smsCode));
          await _signInWithPhoneCreds(credential);
        },
        timeout: const Duration(seconds: 120),
        verificationFailed: (FirebaseAuthException e) {
          showError(e.code);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint(e.toString());
      showError('something-went-wrong');
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      showLoading();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId ?? "", smsCode: otp);
      await _signInWithPhoneCreds(credential);
    } catch (e) {
      debugPrint(e.toString());
      showError("something-went-wrong");
    } finally {
      closeLoading();
    }
  }

  Future<void> _signInWithPhoneCreds(PhoneAuthCredential credential) async {
    try {
      showLoading();
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user != null) {
        await saveToken();
      }
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    } catch (e) {
      debugPrint(e.toString());
      showError("something-went-wrong");
    } finally {
      closeLoading();
    }
  }

  Future<void> resendOtp() async {
    await phoneNumberSignIn(state.phoneNumber ?? "");
  }

  void startTimeout() {
    const int timerMaxSeconds = 120;

    int currentSeconds = 0;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentSeconds = timer.tick;
      String timerText =
          'Resend OTP in ${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
      if (!state.isAuthenticated) {
        emit(state.copyWith(resendText: timerText, canResendOtp: false));
      }
      if (timer.tick >= timerMaxSeconds) {
        emit(state.copyWith(resendText: 'Resend OTP', canResendOtp: true));
        timer.cancel();
      }
    });
  }

  //* Google Login

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.user != null) {
        await saveToken();
      }
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    } catch (e) {
      debugPrint(e.toString());
      showError('something-went-wrong');
    } finally {
      closeLoading();
    }
  }

  //* Apple Login

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> appleSignin() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    try {
      showLoading();
      final appleCredential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      var user = await FirebaseAuth.instance.signInWithCredential(
        OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        ),
      );
      if (user.user != null) {
        await saveToken();
      }
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    } catch (e) {
      debugPrint(e.toString());
      showError('something-went-wrong');
    } finally {
      closeLoading();
    }
  }

  // * Facebook Login

  Future<void> signInWithFacebook() async {
    try {
      showLoading();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        var user = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        if (user.user != null) {
          await saveToken();
        }
      }
    } on FirebaseAuthException catch (e) {
      showError(e.code);
    } catch (e) {
      debugPrint(e.toString());
      showError('something-went-wrong');
    } finally {
      closeLoading();
    }
  }

  Future<void> saveToken() async {
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    _prefs.setString(PrefConstant.authToken, token);
    _prefs.setBool(PrefConstant.authSkipped, false);
    emit(state.copyWith(isAuthenticated: true));
  }

  Future<void> logout() async {
    try {
      BuildContext context = navigatorKey.currentState!.context;
      FirebaseAuth.instance.signOut();
      Pref.instance.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      Pref.instance.clear();
      emit(state.copyWith(isAuthenticated: false));
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        emit(state.copyWith(requiresRecentLogin: true));
        emit(state.copyWith(requiresRecentLogin: false));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showError(String errorCode) {
    emit(state.copyWith(error: true, errorCode: errorCode));
  }

  void clearError() {
    emit(state.copyWith(error: false, errorCode: null));
  }
}
