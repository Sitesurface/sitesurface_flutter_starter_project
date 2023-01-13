import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../flavors/config/flavor_config.dart';

class AppReviewHelper {
  static Future<void> rateApp() async {
    try {
      final InAppReview inAppReview = InAppReview.instance;
      await inAppReview.openStoreListing(
        appStoreId: FlavorConfig.instance.appStoreId,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
