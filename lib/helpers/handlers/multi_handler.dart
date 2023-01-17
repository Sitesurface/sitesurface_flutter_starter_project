import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/helpers/handlers/common_handler.dart';
import 'internet_handler.dart';
import 'locale_handler.dart';
import 'notification_handler.dart';
import 'theme_handler.dart';

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
            child: CommonHandler(
              child: builder(context, theme, locale),
            ),
          ));
        },
      );
    });
  }
}
