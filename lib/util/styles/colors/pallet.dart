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
  static const Color primary = Color(0xffC80111);
  static const Color secondary = Color.fromARGB(255, 150, 138, 90);
  static const whiteBackground = Color(0xfff9f9f9);
  static const whiteBackground2 = Color(0xfff1f5fb);
  static const blueBackground = Color(0xFF4d6cd5);
  static const blueBackground2 = Color(0xFF6984dd);
  static const blueBackground3 = Color(0xff4762C6);
  static const redBackground = Color(0xffee908b);
  static const redBackground2 = Color(0xffF1E8C9);

  static Color? blackBackground = Colors.grey[850];

  Color get grey => brightness == Brightness.dark ? Colors.grey : Colors.grey;
  Color get red => brightness == Brightness.dark ? Colors.red : Colors.red;
  Color get lightGrey => brightness == Brightness.dark
      ? const Color(0xff5A5A5A)
      : const Color(0xffF7F6F9);

  Color? get white =>
      brightness == Brightness.dark ? const Color(0xff292929) : Colors.white;
  Color? get black =>
      brightness == Brightness.dark ? Colors.white : Colors.grey[900];
  Color get green => Colors.greenAccent;
  static const Color greenVar2 = Colors.green;
  Color? get bloodCardBackground =>
      brightness == Brightness.dark ? Colors.grey[900] : whiteBackground2;
}
