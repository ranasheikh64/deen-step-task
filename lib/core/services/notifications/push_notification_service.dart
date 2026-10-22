import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Service managing FCM push notifications and reliable device registration
class PushNotificationService {
  const PushNotificationService({required this.secureStorage});

  final SecureStorageService secureStorage;

  static const String _deviceIdKey = 'persistent_device_id';

  /// Initializes notification permission request and foreground listeners
  Future<void> initialize() async {
    try {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('🔔 [FCM] Notification status: ${settings.authorizationStatus}');
    } on Object catch (e) {
      debugPrint('⚠️ [FCM] Notification init skipped: $e');
    }
  }

  /// Retrieves the FCM device token or a persistent fallback device identifier
  Future<String> getDeviceId() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        debugPrint('📱 [FCM] Device Token: $token');
        await secureStorage.write(_deviceIdKey, token);
        return token;
      }
    } on Object catch (e) {
      debugPrint('⚠️ [FCM] Token fetch fallback: $e');
    }

    // Fallback to locally persisted device ID so API never receives null
    final cachedId = await secureStorage.read(_deviceIdKey);
    if (cachedId != null && cachedId.isNotEmpty) {
      return cachedId;
    }

    final fallbackId = 'dev_fcm_${DateTime.now().millisecondsSinceEpoch}';
    await secureStorage.write(_deviceIdKey, fallbackId);
    return fallbackId;
  }
}
