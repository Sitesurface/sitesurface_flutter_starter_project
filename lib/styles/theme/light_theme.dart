import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/pallet.dart';

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
  textTheme: _lightTextTheme,
  appBarTheme: _lightAppBarTheme,
);

TextTheme _lightTextTheme =
    GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme);

AppBarTheme _lightAppBarTheme = ThemeData.light().appBarTheme.copyWith(
    backgroundColor: Pallet.whiteBackground,
    elevation: 0,
    foregroundColor: Colors.black);
