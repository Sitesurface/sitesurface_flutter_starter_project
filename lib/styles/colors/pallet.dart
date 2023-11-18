import 'package:flutter/material.dart';

extension Pallet on ColorScheme {
  static MaterialColor appColor = MaterialColor(
    primary.value,
    <int, Color>{
      50: primary.withOpacity(0.05),
      100: primary.withOpacity(0.1),
      200: primary.withOpacity(0.2),
      300: primary.withOpacity(0.3),
      400: primary.withOpacity(0.4),
      500: primary.withOpacity(0.5),
      600: primary.withOpacity(0.6),
      700: primary.withOpacity(0.7),
      800: primary.withOpacity(0.8),
      900: primary.withOpacity(0.9),
    },
  );
  static const Color primary = Color(0xff05837F);
  static const Color secondary = Color(0xffF07965);
  static const whiteBackground = Color(0xfff9f9f9);

  static const linkColor = Colors.blue;

  static Color? blackBackground = Colors.grey[850];

  Color get grey => brightness == Brightness.dark ? Colors.grey : Colors.grey;
  Color get lightGrey => brightness == Brightness.dark
      ? const Color(0xff5A5A5A)
      : const Color(0xffF7F6F9);

  Color? get white =>
      brightness == Brightness.dark ? const Color(0xff292929) : Colors.white;
  Color? get black =>
      brightness == Brightness.dark ? Colors.white : Colors.grey[900];
}
