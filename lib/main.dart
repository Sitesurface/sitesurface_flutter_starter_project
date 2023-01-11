import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cache/shared_preferences.dart';
import 'flavors/config/flavor_config.dart';
import 'l10n/provider/locale_notifier.dart';
import 'routes/route_helper.dart';
import 'splash/splash_screen.dart';
import 'util/network/internet_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'util/styles/theme/dark_theme.dart';
import 'util/styles/theme/light_theme.dart';
import 'util/styles/theme/provider/theme_notifier.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future mainCommon() async {
  runZonedGuarded<Future<void>>(() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await Pref.instance.init();
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(const MyApp());
  }, (error, stack) {
    // FirebaseCrashlytics.instance.recordError(error, stack),
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<LocaleNotifier>(
        valueListenable: LocaleNotifier.localeNotifier,
        builder: (context, locale, child) {
          return ValueListenableBuilder<ThemeNotifier>(
            valueListenable: ThemeNotifier.themeNotifier,
            builder: (context, theme, child) {
              return InternetHandler(
                child: MaterialApp(
                  navigatorKey: navigatorKey,
                  debugShowCheckedModeBanner: false,
                  title: FlavorConfig.instance.appName ?? "",
                  builder: BotToastInit(),
                  navigatorObservers: [
                    BotToastNavigatorObserver(),
                  ],
                  scrollBehavior: const ScrollBehavior(
                      // ignore: deprecated_member_use
                      androidOverscrollIndicator:
                          AndroidOverscrollIndicator.stretch),
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: locale.getLocaleMode(),
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: theme.getThemeMode(),
                  onGenerateRoute: RouteHelper.generateRoute,
                  initialRoute: SplashScreen.id,
                ),
              );
            },
          );
        });
  }
}
