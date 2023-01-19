import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/asset_constants.dart';
import 'package:sitesurface_flutter_starter_project/util/asset_helper/asset_helper.dart';

import '../widget/onboard_widget.dart';

class OnboardData {
  static List<OnboardWidget> onboardData = [
    OnboardWidget(
      title: "Flutter Starter Project",
      subtitle:
          "Everything included in this project is to help you get started with your next Flutter project.",
      backgroundImage: const AssetHelper(image: AssetConstants.lottieBg1),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      lottie: const AssetHelper(image: AssetConstants.lottieOnboarding1),
    ),
    OnboardWidget(
      title: "Start your project with this starter project",
      subtitle:
          "This starter project includes all the necessary features to get you started with your next Flutter project.",
      backgroundImage: const AssetHelper(image: AssetConstants.lottieBg2),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      lottie: const AssetHelper(image: AssetConstants.lottieOnboarding2),
    ),
    OnboardWidget(
      title: "Perfect for your next project",
      subtitle:
          "Everything handled out of the box. Just add your own features and you're good to go.",
      backgroundImage: const AssetHelper(image: AssetConstants.lottieBg3),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      lottie: const AssetHelper(image: AssetConstants.lottieOnboarding3),
    ),
  ];
}
