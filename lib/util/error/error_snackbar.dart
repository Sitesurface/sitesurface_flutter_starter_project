import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/styles/colors/pallet.dart';
import 'package:sitesurface_flutter_starter_project/styles/theme/theme_ext.dart';

showErrorSnackBar({
  required String message,
  required BuildContext context,
}) {
  final colorScheme = context.colorScheme;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.all(8.0),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.0,
      backgroundColor: colorScheme.black,
      content: Text(
        message,
      ),
    ),
  );
}
