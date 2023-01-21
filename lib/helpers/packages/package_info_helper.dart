import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoHelper {
  static final PackageInfoHelper _obj = PackageInfoHelper._internal();

  static PackageInfoHelper get instance => _obj;

  PackageInfo? packageInfo;

  factory PackageInfoHelper() {
    return _obj;
  }

  PackageInfoHelper._internal();

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
