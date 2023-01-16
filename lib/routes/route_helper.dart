import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/features/auth/bloc/auth_bloc.dart';
import 'package:sitesurface_flutter_starter_project/features/auth/view/otp_screen.dart';
import '../constants/assets/asset_constants.dart';
import '../features/auth/view/login_screen.dart';
import '../features/dashboard/dashboard.dart';
import '../features/onboarding/view/onboarding_screens.dart';
import '../l10n/l10n.dart';
import '../splash/splash_screen.dart';
import '../util/error/error_screen.dart';
import '../widgets/webview_screen.dart';

class RouteHelper {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case SplashScreen.id:
          return MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          );
        case OnboardingScreen.id:
          return MaterialPageRoute(
            builder: (context) => OnboardingScreen(),
          );
        case LoginScreen.id:
          return MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          );
        case OtpScreen.id:
          final authBloc = settings.arguments as AuthBloc;
          return MaterialPageRoute(
            builder: (context) => OtpScreen(
              authBloc: authBloc,
            ),
          );
        case Dashboard.id:
          return MaterialPageRoute(
            builder: (context) => const Dashboard(),
          );

        case WebViewScreen.id:
          final webViewData = settings.arguments as WebViewData;
          return MaterialPageRoute(
            builder: (context) => WebViewScreen(
              webViewData: webViewData,
            ),
          );
        default:
          return MaterialPageRoute(
            builder: (context) {
              return ErrorScreen(
                image: AssetConstants.error_404,
                title: AppLocalizations.of(context)?.somethingWentWrong,
                description:
                    AppLocalizations.of(context)?.sorryCantProcessDescription,
              );
            },
          );
      }
    } catch (e) {
      debugPrint(e.toString());
      return MaterialPageRoute(
        builder: (context) {
          return ErrorScreen(
            image: AssetConstants.error_404,
            title: AppLocalizations.of(context)?.somethingWentWrong,
            description:
                AppLocalizations.of(context)?.sorryCantProcessDescription,
          );
        },
      );
    }
  }
}
