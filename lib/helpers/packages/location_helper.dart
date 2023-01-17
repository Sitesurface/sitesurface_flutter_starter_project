// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<LatLong?> getLocationLatLng() async {
    try {
      var permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus == LocationPermission.always ||
          permissionStatus == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return LatLong(position.latitude, position.longitude);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

class LatLong {
  const LatLong(double latitude, double longitude)
      : assert(latitude != null),
        assert(longitude != null),
        latitude =
            latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude),
        longitude = longitude >= -180 && longitude < 180
            ? longitude
            : (longitude + 180.0) % 360.0 - 180.0;

  final double latitude;

  final double longitude;

  @override
  bool operator ==(Object other) {
    return other is LatLong &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => Object.hash(latitude, longitude);
}
