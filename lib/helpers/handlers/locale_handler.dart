import 'package:flutter/material.dart';

import '../../cache/prefs_constant.dart';
import '../../cache/shared_preferences.dart';

class LocaleHandler extends StatelessWidget {
  static final _localeNotifier =
      ValueNotifier<Locale>(const Locale("en", "US"));
  final Widget Function(BuildContext context, Locale locale) builder;
  const LocaleHandler({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _localeNotifier,
        builder: (context, locale, _) => builder(context, locale));
  }

  static Locale getLocale() {
    String? lang = Pref.instance.pref.getString(
      PrefConstant.language,
    );

    switch (lang?.toLowerCase()) {
      case "en":
        return const Locale("en", "US");
      case "es":
        return const Locale("es", "ES");
      case "da":
        return const Locale("da", "DK");
      default:
        return const Locale('en', 'US');
    }
  }

  static void setLocale(Locale locale) async {
    _localeNotifier.value = locale;
    Pref.instance.pref.setString(PrefConstant.language, locale.languageCode);
  }
}
