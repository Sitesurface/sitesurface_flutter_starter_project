import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/util/asset_helper/asset_helper.dart';
import 'package:sitesurface_flutter_starter_project/util/extentions/extensions.dart';
import 'package:sitesurface_flutter_starter_project/widgets/buttons/rounded_button.dart';

class PermissionWidget extends StatelessWidget {
  final String image;
  final String? title;
  final String? subtitle;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final String? primaryButtonLabel;
  final void Function()? onPrimaryButtonTapped;
  final String? secondaryButtonLabel;
  final void Function()? onsecondaryButtonTapped;

  PermissionWidget(
      {super.key,
      required this.image,
      this.title,
      this.subtitle,
      this.primaryButton,
      this.secondaryButton,
      this.primaryButtonLabel,
      this.onPrimaryButtonTapped,
      this.secondaryButtonLabel,
      this.onsecondaryButtonTapped}) {
    if (primaryButton == null) {
      assert(primaryButtonLabel != null && onPrimaryButtonTapped != null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = context.textTheme;
    var colorScheme = context.colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AssetHelper(image: image),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title ?? "",
                style: textTheme.bodyLarge,
              ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  subtitle ?? "",
                  style: textTheme.bodyMedium,
                ),
              ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            primaryButton ??
                RoundedButton(
                    label: primaryButtonLabel ?? "",
                    onPressed: onPrimaryButtonTapped),
            secondaryButton ??
                TextButton(
                  onPressed: onsecondaryButtonTapped,
                  child: Text(
                    secondaryButtonLabel ?? "",
                    style: textTheme.bodyMedium
                        ?.copyWith(color: colorScheme.secondary),
                  ),
                )
          ],
        ),
      ],
    );
  }
}
