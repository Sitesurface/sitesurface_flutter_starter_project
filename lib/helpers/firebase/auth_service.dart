import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../cache/shared_preferences.dart';

class AuthService {
  // * Email Login

  static final auth = FirebaseAuth.instance;
  static String? _verificationId;

  static Future<UserCredential?> emailLogin(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await createUserEmail(emailAddress: emailAddress, password: password);
      } else {
        debugPrint(e.code);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<UserCredential?> createUserEmail(
      {required String emailAddress, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<void> forgetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      await auth.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await emailLogin(emailAddress: email, password: oldPassword);
        await changePassword(email, oldPassword, newPassword);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // * Phone number Login

  static Future<void> phoneNumberSignIn({
    required String phoneNumber,
    void Function(UserCredential?)? onVerificationCompleted,
  }) async {
    UserCredential? user;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.replaceAll(" ", ""),
        verificationCompleted: (PhoneAuthCredential credential) async {
          user = await _signInWithPhoneCreds(credential);
          if (onVerificationCompleted != null) {
            onVerificationCompleted(user);
          }
        },
        timeout: const Duration(seconds: 120),
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.code);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  Future<void> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId ?? "", smsCode: otp);
      await _signInWithPhoneCreds(credential);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<UserCredential?> _signInWithPhoneCreds(
      PhoneAuthCredential credential) async {
    try {
      var user = await auth.signInWithCredential(credential);
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<void> resendOtp(String? phoneNumber) async {
    try {
      await phoneNumberSignIn(phoneNumber: phoneNumber ?? "");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //* Google Login

  Future<UserCredential?> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var user = await auth.signInWithCredential(credential);
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  //* Apple Login

  static String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<UserCredential?> appleSignin() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    try {
      final appleCredential =
          await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ], nonce: nonce);

      var user = await auth.signInWithCredential(
        OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
        ),
      );
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  // * Facebook Login

  static Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        var user = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<String> getToken() async {
    var token = await auth.currentUser!.getIdToken();
    return token;
  }

  static Future<void> logout() async {
    try {
      auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> deleteAccount() async {
    try {
      await auth.currentUser?.delete();
      Pref.instance.clear();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
