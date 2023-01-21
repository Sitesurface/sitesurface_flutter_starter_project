import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'config/build_flavor.dart';
import 'config/firebase/firebase_options_dev.dart';
import 'config/flavor_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlavorConfig().setupFlavor(flavorConfig: BuildFlavor.dev);
  await Firebase.initializeApp(
    options: DevDefaultFirebaseOptions.currentPlatform,
  );

  mainCommon();
}
