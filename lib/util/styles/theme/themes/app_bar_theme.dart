import 'package:flutter/material.dart';

import '../../colors/pallet.dart';

const AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: Pallet.whiteBackground,
    elevation: 0,
    foregroundColor: Colors.black);

AppBarTheme lightAppBarTheme = ThemeData.light().appBarTheme.copyWith(
    backgroundColor: Pallet.whiteBackground,
    elevation: 0,
    foregroundColor: Colors.black);
AppBarTheme darkAppBarTheme = ThemeData.dark().appBarTheme.copyWith(
    backgroundColor: Pallet.blackBackground,
    elevation: 0,
    foregroundColor: Colors.white);
