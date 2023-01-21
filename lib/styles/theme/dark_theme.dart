import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/pallet.dart';

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
  textTheme: _darkTextTheme,
  appBarTheme: _darkAppBarTheme,
);

TextTheme _darkTextTheme =
    GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme);

AppBarTheme _darkAppBarTheme = ThemeData.dark().appBarTheme.copyWith(
    backgroundColor: Pallet.blackBackground,
    elevation: 0,
    foregroundColor: Colors.white);
