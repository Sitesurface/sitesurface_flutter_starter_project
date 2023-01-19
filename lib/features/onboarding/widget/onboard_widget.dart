import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/styles/theme/theme_ext.dart';

class OnboardWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget lottie;
  final Widget backgroundImage;

  OnboardWidget({
    required this.title,
    required this.subtitle,
    required this.lottie,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    required this.backgroundImage,
  });
}

class OnboardCard extends StatelessWidget {
  const OnboardCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final OnboardWidget data;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Stack(
      children: [
        data.backgroundImage,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Flexible(
                flex: 20,
                child: data.lottie,
              ),
              const Spacer(flex: 1),
              Text(
                data.title.toUpperCase(),
                style: textTheme.bodyLarge?.copyWith(
                  color: data.titleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
                maxLines: 1,
              ),
              const Spacer(flex: 1),
              Text(
                data.subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: data.subtitleColor,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Spacer(flex: 10),
            ],
          ),
        ),
      ],
    );
  }
}
