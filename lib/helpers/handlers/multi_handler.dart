import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/helpers/handlers/internet_handler.dart';
import 'package:sitesurface_flutter_starter_project/helpers/handlers/locale_handler.dart';
import 'package:sitesurface_flutter_starter_project/helpers/handlers/theme_handler.dart';
import 'package:sitesurface_flutter_starter_project/util/notification/notification_handler.dart';

class MultiHandler extends StatelessWidget {
  const MultiHandler({super.key, required this.builder});
  final Widget Function(BuildContext, ThemeMode, Locale) builder;

  @override
  Widget build(BuildContext context) {
    return ThemeHandler(builder: (context, theme) {
      return LocaleHandler(
        builder: (context, locale) {
          return InternetHandler(
              child: NotificationHandler(
            child: builder(context, theme, locale),
          ));
        },
      );
    });
  }
}
