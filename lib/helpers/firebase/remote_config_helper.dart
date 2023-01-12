import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigHelper {
  static final _remoteConfig = FirebaseRemoteConfig.instance;

  static Future<void> setConfigSettings() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }
}
