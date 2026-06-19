import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase/firebase_initializer.dart';

const AndroidNotificationChannel _androidNotificationChannel =
    AndroidNotificationChannel(
      'elite_high_importance_channel',
      'Elite Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FirebaseInitializer.initialize();
  debugPrint('Handling background message: ${message.messageId}');
}

class PushNotificationService {
  PushNotificationService._();

  static final PushNotificationService instance = PushNotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (!FirebaseInitializer.isSupportedPlatform || _isInitialized) {
      return;
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _initializeLocalNotifications();
    await _configureForegroundPresentation();
    await _configureMessageStreams();
    await _logToken();

    _isInitialized = true;
  }

  Future<void> _initializeLocalNotifications() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    final androidImplementation = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidImplementation?.createNotificationChannel(
      _androidNotificationChannel,
    );
  }

  Future<void> requestPermission() async {
    if (!FirebaseInitializer.isSupportedPlatform) {
      return;
    }

    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('Push notification permission: ${settings.authorizationStatus}');
  }

  Future<void> _configureForegroundPresentation() {
    return _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _configureMessageStreams() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    _messaging.onTokenRefresh.listen(
      (token) => debugPrint('FCM token refreshed: $token'),
    );
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) {
      return;
    }

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _androidNotificationChannel.id,
        _androidNotificationChannel.name,
        channelDescription: _androidNotificationChannel.description,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _localNotificationsPlugin.show(
      id: notification.hashCode,
      title: notification.title ?? 'Elite',
      body: notification.body ?? '',
      notificationDetails: notificationDetails,
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification opened: ${message.messageId}');
    debugPrint('Notification data: ${message.data}');
  }

  Future<void> _logToken() async {
    final token = await _messaging.getToken();
    debugPrint('FCM token: $token');
  }
}
