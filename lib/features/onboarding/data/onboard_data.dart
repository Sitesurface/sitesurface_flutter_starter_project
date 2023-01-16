import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/lottie_constants.dart';

import '../../../util/asset_helper/lottie_helper.dart';
import '../widget/onboard_widget.dart';

class OnboardData {
  static List<OnboardWidget> onboardData = [
    OnboardWidget(
      title: "Flutter Starter Project",
      subtitle:
          "Everything included in this project is to help you get started with your next Flutter project.",
      backgroundImage: const LottieAsset(assetName: LottieConstants.bg1),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      lottie: const LottieAsset(assetName: LottieConstants.onboarding1),
    ),
    OnboardWidget(
      title: "Start your project with this starter project",
      subtitle:
          "This starter project includes all the necessary features to get you started with your next Flutter project.",
      backgroundImage: const LottieAsset(assetName: LottieConstants.bg2),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      lottie: const LottieAsset(assetName: LottieConstants.onboarding2),
    ),
    OnboardWidget(
      title: "Perfect for your next project",
      subtitle:
          "Everything handled out of the box. Just add your own features and you're good to go.",
      backgroundImage: const LottieAsset(assetName: LottieConstants.bg3),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      lottie: const LottieAsset(assetName: LottieConstants.onboarding3),
    ),
  ];
}
