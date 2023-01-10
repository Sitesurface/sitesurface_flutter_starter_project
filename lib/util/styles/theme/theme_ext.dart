import 'package:flutter/material.dart';

extension TextThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
extension ColorSchemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
