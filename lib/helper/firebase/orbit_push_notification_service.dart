import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class OrbitPushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  AndroidNotificationChannel? _channel;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  OrbitPushNotificationService() {
    initialize();
  }

  Future initialize() async {
    if (Platform.isIOS) {
      await _iosForegroundNotif();
    }
    await _iosSettings();
    await _initializeSettings();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        if (Platform.isAndroid) {
          displayForegroundNotification(message);
        }
      }
    });
    setupInteractedMessage();
    print('fcmToken => ${await getToken()}');
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    return token;
  }

  Future<void> _iosSettings() async {
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void displayForegroundNotification(RemoteMessage message) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('orbit_client_android_notifications',
            'Orbit Client Android Notifications',
            importance: Importance.max,
            priority: Priority.high,
            icon: message.notification!.android!.smallIcon);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      platformChannelSpecifics,
    );
  }

  Future<void> onSelectNotificationForeground(
      NotificationResponse? response) async {}

  Future<void> _initializeSettings() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('splash');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
            );
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotificationForeground);
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle local notification
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      await _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      await _handleMessage(message);
      // await AppSessionHelper.checkSessionOnNotification();
    });
  }

  Future<void> _handleMessage(RemoteMessage message) async {}

  Future _iosForegroundNotif() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
}
