import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // NotificationServices(){
  //   firebaseInit();
  //   isTokenRefresh();
  //   requestNotificationPermission();
  //   getDeviceToken().then((value){
  //     print("Device token");
  //     print(value);
  //   });
  //
  // }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
      provisional: false,
      carPlay: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User denied or has not granted permission");
    }
  }

  // Initialize local notifications
  void initLocalization() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Ensure this path is correct
    const InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("Notification clicked: ${response.payload}");
      },
    );
  }

  // Display notification via GetX Snackbar
  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Message received in foreground:");
        print("Title: ${message.notification?.title}");
        print("Body: ${message.notification?.body}");
      }

      if (message.notification != null) {
        final String title = message.notification?.title ?? "Notification";
        final String body = message.notification?.body ?? "You have a new message!";
        Get.snackbar(
          title,
          body,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          duration: const Duration(seconds: 5),
          margin: const EdgeInsets.all(10),
        );
      }
    });
  }

  // Retrieve the device's Firebase token
  Future<String?> getDeviceToken() async {
    try {
      String? token = await messaging.getToken();
      print("Device Token: $token");
      return token;
    } catch (e) {
      print("Error retrieving device token: $e");
      return null;
    }
  }

  // Listen for token refresh
  // void isTokenRefresh() {
  //   messaging.onTokenRefresh.listen((String newToken) {
  //     print("Token refreshed: $newToken");
  //   });
  // }
}
