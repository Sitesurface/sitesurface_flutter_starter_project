import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/features/home/auth/bloc/auth_bloc.dart';
import 'package:sitesurface_flutter_starter_project/features/home/auth/view/otp_screen.dart';
import '../constants/assets/asset_constants.dart';
import '../features/home/auth/view/login_screen.dart';
import '../features/home/dashboard/dashboard.dart';
import '../features/home/onboarding/view/onboarding_screens.dart';
import '../util/extentions/extensions.dart';
import '../features/home/splash/splash_screen.dart';
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
                image: AssetConstants.imageError404,
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
            image: AssetConstants.imageError404,
            title: AppLocalizations.of(context)?.somethingWentWrong,
            description:
                AppLocalizations.of(context)?.sorryCantProcessDescription,
          );
        },
      );
    }
  }
}
