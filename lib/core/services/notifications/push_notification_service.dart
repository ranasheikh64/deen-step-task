import 'package:deen_app/core/services/storage/secure_storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🌙 [FCM] Background message: ${message.messageId}');
}

/// Service managing FCM push notifications and foreground local banners
class PushNotificationService {
  PushNotificationService({
    required this.secureStorage,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _localNotifications = localNotifications ?? FlutterLocalNotificationsPlugin();

  final SecureStorageService secureStorage;
  final FlutterLocalNotificationsPlugin _localNotifications;

  static const String _deviceIdKey = 'persistent_device_id';
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'deen_high_importance_channel',
    'Deen Notifications',
    description: 'Notifications from Deen App',
    importance: Importance.high,
  );

  /// Initializes notification permission, local notification channel, and foreground listeners
  Future<void> initialize() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(alert: true, badge: true, sound: true);

      await _initLocalNotifications();
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true,
      );

      final token = await messaging.getToken();
      if (token != null && token.isNotEmpty) {
        _logToken(token);
        await secureStorage.write(_deviceIdKey, token);
      }

      messaging.onTokenRefresh.listen((newToken) async {
        _logToken(newToken);
        await secureStorage.write(_deviceIdKey, newToken);
      });

      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } on Object catch (e) {
      debugPrint('⚠️ [FCM] Notification init error: $e');
    }
  }

  Future<void> _initLocalNotifications() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _localNotifications.initialize(settings: initSettings);
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('🔔 [FCM] Foreground notification: ${message.notification?.title}');
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      id: notification.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id, _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high, priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(presentAlert: true, presentSound: true),
      ),
    );
  }

  /// Retrieves the FCM device token or a persistent fallback device identifier
  Future<String> getDeviceId() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null && token.isNotEmpty) {
        _logToken(token);
        await secureStorage.write(_deviceIdKey, token);
        return token;
      }
    } on Object catch (e) {
      debugPrint('⚠️ [FCM] Token fetch fallback: $e');
    }

    final cachedId = await secureStorage.read(_deviceIdKey);
    if (cachedId != null && cachedId.isNotEmpty) return cachedId;

    final fallbackId = 'dev_fcm_${DateTime.now().millisecondsSinceEpoch}';
    await secureStorage.write(_deviceIdKey, fallbackId);
    return fallbackId;
  }

  void _logToken(String token) {
    debugPrint('══════════════════ [FCM DEVICE TOKEN] ══════════════════');
    debugPrint(token);
    debugPrint('═════════════════════════════════════════════════════════');
  }
}
