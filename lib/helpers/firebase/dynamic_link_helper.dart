import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../flavors/config/flavor_config.dart';
import '../../util/bot_toast/bot_toast_functions.dart';

/// This class is used to handle the deep link.
/// It will check the deep link and open the post details screen.
/// It will open the post details screen based on the deep link.
class DynamicLinkHelper {
  /// This function is used to create the dynamic link using firebase dynamic links.
  static Future<String?> createDynamicLink({required Uri link}) async {
    String? linkMessage;
    final dynamicLinkParams = DynamicLinkParameters(
      link: link,
      uriPrefix: FlavorConfig.instance.dynamicLink!,
      androidParameters:
          AndroidParameters(packageName: FlavorConfig.instance.packageName!),
      iosParameters: IOSParameters(
        bundleId: FlavorConfig.instance.packageName!,
        appStoreId: FlavorConfig.instance.appStoreId,
      ),
    );
    showLoading();
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    closeLoading();
    linkMessage = dynamicLink.shortUrl.toString();
    return linkMessage;
  }

  /// This function is used to open the appropriate scence based on the deep link query.
  static Future<void> initDynamicLink(BuildContext context) async {
    var navigator = Navigator.of(context);
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    try {
      if (data != null) {
        final Uri deepLink = data.link;
        String? type = deepLink.queryParameters['type'];

        switch (type) {
          case "share":
            _handleShareLink(deepLink, navigator);
            break;
          default:
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> addFirebaseDynamicLinkListener(
      NavigatorState navigatorState) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      var screen = dynamicLinkData.link.path;
      var arguments = dynamicLinkData.link.queryParameters;
      navigatorState.pushNamed(screen, arguments: arguments);
    }).onError((error) {
      debugPrint(error);
    });
  }
}

/// This function is used to open the post details screen based on the deep link.
void _handleShareLink(Uri deepLink, NavigatorState navigatorState) {
  var screen = deepLink.path;
  var arguments = deepLink.queryParameters;
  navigatorState.pushNamed(screen, arguments: arguments);
}
