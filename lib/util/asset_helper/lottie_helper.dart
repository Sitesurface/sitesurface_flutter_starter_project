import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAsset extends StatelessWidget {
  const LottieAsset(
      {super.key, required this.assetName, this.height, this.width, this.fit});
  final String assetName;
  final double? height, width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(assetName,
        fit: fit, height: height, width: width);
  }
}
