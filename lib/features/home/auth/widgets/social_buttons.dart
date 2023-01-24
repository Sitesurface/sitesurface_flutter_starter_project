import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/util/extentions/extensions.dart';

import '../../../../util/asset_helper/asset_helper.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.assetName,
    required this.onPressed,
  }) : super(key: key);

  final String assetName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Expanded(
      child: TextButton(
        onPressed: () => onPressed(),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AssetHelper(
            image: assetName,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
