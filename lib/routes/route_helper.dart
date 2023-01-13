import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/l10n/l10n.dart';
import '../constants/assets/asset_constants.dart';
import '../splash/splash_screen.dart';
import '../util/error/error_screen.dart';

class RouteHelper {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case SplashScreen.id:
          return MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          );

        default:
          return MaterialPageRoute(
            builder: (context) {
              final locale = context.l10n;
              return ErrorScreen(
                image: AssetConstants.error_404,
                title: locale.somethingWentWrong,
                description: locale.sorryCantProcessDescription,
              );
            },
          );
      }
    } catch (e) {
      debugPrint(e.toString());
      return MaterialPageRoute(
        builder: (context) {
          final locale = context.l10n;
          return ErrorScreen(
            image: AssetConstants.error_404,
            title: locale.somethingWentWrong,
            description: locale.sorryCantProcessDescription,
          );
        },
      );
    }
  }
}
