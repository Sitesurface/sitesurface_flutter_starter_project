import 'package:geolocator/geolocator.dart';

import '../../cache/prefs_constant.dart';
import '../../cache/shared_preferences.dart';

class GetLatiLongiLocation {
  static getUserLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final pref = Pref.instance.pref;
      pref.setDouble(PrefConstant.latitude, position.latitude);
      pref.setDouble(PrefConstant.longitude, position.longitude);
    } catch (e) {
      throw Exception('Location permissions are denied');
    }
  }
//TODO: Implement LatLng class
  // static Future<LatLng> getLocationLatLng() async {
  //   var permissionStatus = await Geolocator.requestPermission();
  //   if (permissionStatus == LocationPermission.always ||
  //       permissionStatus == LocationPermission.whileInUse) {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     return LatLng(position.latitude, position.longitude);
  //   }
  //   throw Exception('Location permissions are denied');
  // }
}
