import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_starter_project/helpers/packages/package_info_helper.dart';
import 'package:sitesurface_flutter_starter_project/main.dart';

import '../../flavors/config/flavor_config.dart';
import '../handlers/action_handler.dart';

/// This class is used to handle the deep link.
class DynamicLinkHelper {
  /// This function is used to create the dynamic link using firebase dynamic links.
  static Future<String?> createDynamicLink({required Uri link}) async {
    String? linkMessage;
    final dynamicLinkParams = DynamicLinkParameters(
      link: link,
      uriPrefix: FlavorConfig.instance.dynamicLink!,
      androidParameters: AndroidParameters(
          packageName: PackageInfoHelper.instance.packageInfo.packageName),
      iosParameters: IOSParameters(
        bundleId: PackageInfoHelper.instance.packageInfo.packageName,
        appStoreId: FlavorConfig.instance.appStoreId,
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    linkMessage = dynamicLink.shortUrl.toString();
    return linkMessage;
  }

  /// This function is used to open the appropriate scence based on the deep link query.
  static Future<void> initDynamicLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    try {
      if (data != null) {
        final Uri deepLink = data.link;
        ActionHandler.handle(deepLink);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> addFirebaseDynamicLinkListener() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      var screen = dynamicLinkData.link.path;
      var arguments = dynamicLinkData.link.queryParameters;
      Navigator.of(navigatorKey.currentState!.context)
          .pushNamed(screen, arguments: arguments);
    }).onError((error) {
      debugPrint(error);
    });
  }
}
