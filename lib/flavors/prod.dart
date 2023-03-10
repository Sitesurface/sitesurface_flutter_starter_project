import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../helpers/firebase/crashlytics_helper.dart';

import '../main.dart';
import 'config/build_flavor.dart';
import 'config/firebase/firebase_options_prod.dart';
import 'config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlavorConfig().setupFlavor(flavorConfig: BuildFlavor.prod);
  await Firebase.initializeApp(
    options: ProdDefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();
  CrashlyticsHelper.init();
  mainCommon();
}
