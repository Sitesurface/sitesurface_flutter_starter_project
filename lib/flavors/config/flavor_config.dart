import 'build_flavor.dart';

/// Initialise and assign values to each specific flavor here
/// Current flavors [dev, prod]
class FlavorConfig {
  static final FlavorConfig _obj = FlavorConfig._internal();

  static FlavorConfig get instance => _obj;

  //flavor variables
  BuildFlavor? buildFlavor;

  String? baseUrl;
  String? appStoreId;
  String? dynamicLink;

  factory FlavorConfig() {
    return _obj;
  }

  FlavorConfig._internal();

  Future<void> setupFlavor({required BuildFlavor flavorConfig}) async {
    switch (flavorConfig) {
      case BuildFlavor.dev:
        {
          buildFlavor = BuildFlavor.dev;
          baseUrl = '';
          dynamicLink = '';
          appStoreId = '';
        }
        break;
      case BuildFlavor.prod:
        {
          buildFlavor = BuildFlavor.dev;
          baseUrl = '';
          dynamicLink = '';
          appStoreId = '';
        }
        break;
    }
  }
}
