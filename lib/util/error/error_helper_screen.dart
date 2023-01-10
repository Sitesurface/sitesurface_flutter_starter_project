// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/colors/pallet.dart';
import 'package:sitesurface_flutter_starter_project/util/styles/theme/theme_ext.dart';

class ErrorScreen extends StatelessWidget {
  static const String id = "/error";
  const ErrorScreen({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.white,
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Image.asset(
              image,
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 15),
                  child: Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
