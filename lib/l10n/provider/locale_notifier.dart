import 'package:flutter/material.dart';

import '../../cache/prefs_constant.dart';
import '../../cache/shared_preferences.dart';

class LocaleNotifier extends ValueNotifier<Locale> {
  Locale _locale = const Locale('en', 'US');
  static final localeNotifier =
      ValueNotifier<LocaleNotifier>(LocaleNotifier(const Locale("en", "US")));

  LocaleNotifier(this._locale) : super(_locale);

  Locale getLocaleMode() {
    String? lang = Pref.instance.pref.getString(
      PrefConstant.language,
    );
    if (lang?.toLowerCase() == "en") {
      return const Locale("en", "US");
    }
    if (lang?.toLowerCase() == "es") {
      return const Locale("es", "ES");
    }
    if (lang?.toLowerCase() == "da") {
      return const Locale("da", "DK");
    }
    return _locale;
  }

  setLocaleMode(Locale locale) async {
    _locale = locale;
    localeNotifier.value = LocaleNotifier(locale);
    Pref.instance.pref.setString(PrefConstant.language, locale.languageCode);
    notifyListeners();
  }
}
