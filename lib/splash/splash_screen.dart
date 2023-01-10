import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cache/shared_preferences.dart';
import '../cache/prefs_constant.dart';
import '../util/asset_helper/assets_constants.dart';

class SplashScreen extends StatefulWidget {
  static const id = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SharedPreferences _prefs = Pref.instance.pref;

  Future<String> getAuth() async {
    return "";
    if (FirebaseAuth.instance.currentUser != null) {
      var bearerToken = await FirebaseAuth.instance.currentUser!.getIdToken();

      await _prefs.setString(PrefConstant.authToken, bearerToken);
      // return Dashboard.id;
    }
    bool? authSkipped = _prefs.getBool(PrefConstant.authSkipped);
    if (authSkipped != null && authSkipped) {
      // return Dashboard.id;
    }

    bool? onboardingCompleted = _prefs.getBool(PrefConstant.onboardCompleted);
    if (onboardingCompleted != null && onboardingCompleted) {
      // return LoginScreen.id;
    }
    _prefs.remove(PrefConstant.authSkipped);
    _prefs.remove(PrefConstant.authToken);
    _prefs.remove(PrefConstant.onboardCompleted);
    // return OnboardingPage.id;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getAuth(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.isNotEmpty) {
          Future.delayed(Duration.zero,
              () => Navigator.pushReplacementNamed(context, snapshot.data!));
        }
        return Scaffold(
          body: Center(
              child: Image.asset(
            AssetConstants.appLogo,
            height: 100,
            width: 100,
          )),
        );
      },
    );
  }
}
