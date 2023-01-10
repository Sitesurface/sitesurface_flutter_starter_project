import 'package:flutter/material.dart';

import '../colors/pallet.dart';
import 'themes/app_bar_theme.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Pallet.primary,
  brightness: Brightness.light,
  primarySwatch: Pallet.appColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
    ),
  ),
  appBarTheme: lightAppBarTheme,
);
