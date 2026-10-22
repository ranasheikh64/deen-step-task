import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Service managing device location access and permission lifecycle
class LocationService {
  const LocationService();

  /// Checks if location permission has already been granted
  Future<bool> isPermissionGranted() async {
    try {
      final permission = await Geolocator.checkPermission();
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } on Object catch (e) {
      debugPrint('⚠️ [LocationService] checkPermission error: $e');
      return false;
    }
  }

  /// Requests location access from the system
  Future<bool> requestPermission() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } on Object catch (e) {
      debugPrint('⚠️ [LocationService] requestPermission error: $e');
      return false;
    }
  }

  /// Fetches current GPS coordinates if permissions are allowed
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await isPermissionGranted();
      if (!hasPermission) return null;
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } on Object catch (e) {
      debugPrint('⚠️ [LocationService] getCurrentPosition error: $e');
      return null;
    }
  }
}
