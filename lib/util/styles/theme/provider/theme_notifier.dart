import 'package:flutter/material.dart';

import '../../../../cache/prefs_constant.dart';
import '../../../../cache/shared_preferences.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeMode _themeMode = ThemeMode.system;
  static final themeNotifier =
      ValueNotifier<ThemeNotifier>(ThemeNotifier(ThemeMode.system));

  ThemeNotifier(this._themeMode) : super(_themeMode);

  ThemeMode getThemeMode() {
    String? theme = Pref.instance.pref.getString(
      PrefConstant.themeMode,
    );
    if (theme?.toLowerCase() == "light") {
      return ThemeMode.light;
    }
    if (theme?.toLowerCase() == "dark") {
      return ThemeMode.dark;
    }
    return _themeMode;
  }

  setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    themeNotifier.value = ThemeNotifier(mode);
    Pref.instance.pref.setString(
      PrefConstant.themeMode,
      mode.name,
    );
    notifyListeners();
  }
}
