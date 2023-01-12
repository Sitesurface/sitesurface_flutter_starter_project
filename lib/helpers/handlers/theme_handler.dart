import 'package:flutter/material.dart';

import '../../cache/prefs_constant.dart';
import '../../cache/shared_preferences.dart';

class ThemeHandler extends StatelessWidget {
  final Widget Function(BuildContext, ThemeMode) builder;
  const ThemeHandler({super.key, required this.builder});
  static final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.system);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: themeNotifier,
        builder: (context, theme, _) => builder(context, theme));
  }

  static ThemeMode getTheme() {
    String? theme = Pref.instance.pref.getString(
      PrefConstant.themeMode,
    );
    switch (theme?.toLowerCase()) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.light;
      default:
        return ThemeMode.dark;
    }
  }

  static void setTheme(ThemeMode mode) async {
    themeNotifier.value = mode;
    Pref.instance.pref.setString(
      PrefConstant.themeMode,
      mode.name,
    );
  }
}
