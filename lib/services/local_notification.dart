import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('logo');
    const iosSettings = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle tap on notification
      },
    );
  }

  static Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      'websocket_channel',
      'WebSocket Notifications',
      channelDescription: 'Notifications received from WebSocket',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
    );
  }
}
