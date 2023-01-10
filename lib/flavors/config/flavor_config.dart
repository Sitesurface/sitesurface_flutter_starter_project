import 'build_flavor.dart';

/// Initialise and assign values to each specific flavor here
/// Current flavors [dev, prod]
class FlavorConfig {
  static final FlavorConfig _obj = FlavorConfig._internal();

  static FlavorConfig get instance => _obj;

  //flavor variables
  BuildFlavor? buildFlavor;

  String? baseUrl;
  String? appName;
  String? appStoreId;
  String? dynamicLink;
  String? packageName;
  String? fcmKey;

  factory FlavorConfig() {
    return _obj;
  }

  FlavorConfig._internal();

  Future<void> setupFlavor({required BuildFlavor flavorConfig}) async {
    switch (flavorConfig) {
      case BuildFlavor.dev:
        {
          buildFlavor = BuildFlavor.dev;
          baseUrl = 'https://ad44-122-161-79-246.in.ngrok.io';
          appName = "Dev Starter Project";
          packageName = 'com.help1.mobile.dev';
          dynamicLink = 'https://help1dev.page.link';
          appStoreId = '';
          fcmKey =
              "AAAA7-KgYlA:APA91bFaDu_WsZT1pCDBf9bSPoeq61MqXZEY4V-u05GCTzsomgzRNPE7rnXK6JFa8yZO5E0ZAOnROzzDKgTz4vUemvkW3Fcs-Dt3MgBOlcwGJbxP8fnsDbxE6FaGtRus3uJCA14dpBOw";
        }
        break;
      case BuildFlavor.prod:
        {
          buildFlavor = BuildFlavor.prod;
          baseUrl = '';
          appName = "Help1";
          packageName = 'com.help1.mobile';
          dynamicLink = 'https://help1dev.page.link';
          appStoreId = '';
          fcmKey = "";
        }
        break;
    }
  }
}
