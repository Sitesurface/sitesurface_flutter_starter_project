import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/constants/assets/lottie_constants.dart';

import '../../../util/asset_helper/lottie_helper.dart';
import '../widget/onboard_widget.dart';

class OnboardData {
  static List<OnboardWidget> onboardData = [
    OnboardWidget(
      title: "Sharing Made Easy",
      subtitle:
          "Connect with others to give and recieve items for free. Help others by sharing your items.",
      backgroundImage: const LottieAsset(assetName: LottieConstants.bg1),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.pink,
      subtitleColor: Colors.white,
      lottie: const LottieAsset(assetName: LottieConstants.help1),
    ),
    OnboardWidget(
      title: "The Sharing Circle",
      subtitle:
          "Help the needy by donating items to them or by giving blood who needs them urgently.",
      backgroundImage: const LottieAsset(assetName: LottieConstants.bg2),
      backgroundColor: Colors.white,
      titleColor: Colors.purple,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      lottie: const LottieAsset(assetName: LottieConstants.help2),
    ),
    OnboardWidget(
      title: "Help1- The Giving Platform",
      subtitle:
          "Connect with others and share your gently used items for free. Reduce waste and make a positive impact",
      backgroundImage: const LottieAsset(assetName: LottieConstants.bg3),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      lottie: const LottieAsset(assetName: LottieConstants.bg3),
    ),
  ];
}
