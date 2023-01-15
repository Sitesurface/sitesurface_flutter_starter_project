import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/features/onboarding/view/onboarding.dart';
import 'package:sitesurface_flutter_starter_project/l10n/l10n.dart';
import 'package:sitesurface_flutter_starter_project/widgets/webview_screen.dart';
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
        case WebViewScreen.id:
          return MaterialPageRoute(
            builder: (context) => const WebViewScreen(),
          );
        case OnboardingScreen.id:
          return MaterialPageRoute(
            builder: (context) => const WebViewScreen(),
          );
        case WebViewScreen.id:
          return MaterialPageRoute(
            builder: (context) => const WebViewScreen(),
          );
        case WebViewScreen.id:
          return MaterialPageRoute(
            builder: (context) => const WebViewScreen(),
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
