import 'package:flutter/material.dart';

import '../constants/assets/asset_constants.dart';
import '../util/error/error_screen.dart';
import '../util/extentions/extensions.dart';

class ErrorRouteScreen extends StatelessWidget {
  static const String id = "/page-not-found";
  const ErrorRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
      image: AssetConstants.imageError404,
      title: AppLocalizations.of(context)?.somethingWentWrong,
      description: AppLocalizations.of(context)?.sorryCantProcessDescription,
    );
  }
}
