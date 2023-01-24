import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sitesurface_flutter_starter_project/helpers/firebase/analytics_helper.dart';
import 'package:sitesurface_flutter_starter_project/helpers/handlers/multi_handler.dart';
import 'package:sitesurface_flutter_starter_project/helpers/packages/package_info_helper.dart';
import 'cache/shared_preferences.dart';
import 'routes/error_route_screen.dart';
import 'routes/route_helper.dart';
import 'features/home/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'styles/theme/dark_theme.dart';
import 'styles/theme/light_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future mainCommon() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Pref.instance.init();
  await PackageInfoHelper.instance.init();
}

class MyApp extends StatelessWidget {
  final _routeHelper = RouteHelper();
  final _analyticsHelper = AnalyticsHelper();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiHandler(builder: (context, theme, locale) {
      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: PackageInfoHelper.instance.packageInfo.appName,
        builder: BotToastInit(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
          _analyticsHelper.getAnalyticsObserver()
        ],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: theme,
        onGenerateRoute: _routeHelper.getRoutes,
        initialRoute: SplashScreen.id,
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => const ErrorRouteScreen()),
      );
    });
  }
}
