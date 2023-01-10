import 'package:flutter/material.dart';
import '../colors/pallet.dart';
import 'themes/app_bar_theme.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: Pallet.primary,
  primarySwatch: Pallet.appColor,
  brightness: Brightness.dark,
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
  appBarTheme: darkAppBarTheme,
);
