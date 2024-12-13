import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:orbit/controllers/splash_screen_controller.dart';
import 'package:orbit/routes/app_routes.dart';
import 'package:orbit/screens/splash_screen.dart';
import 'package:orbit/services/local_notification.dart';
import 'package:orbit/services/websocket_services.dart';
import 'package:orbit/theme/app_theme.dart';
import 'package:orbit/theme/app_theme_service.dart';
import 'package:orbit/utils/hr_app_internet_checker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'helper/main_helper.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _handleFirebaseBackgroundMessage(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
}

main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();


 // WebSocketServices webSocketServices = WebSocketServices();
 // await webSocketServices.initializeWebSocket();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await NotificationManager.initialize();
  initializeBackgroundFetch();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Get.put(MainHelper(), permanent: true);
  Get.put(HrAppInternetChecker(), permanent: true);
// FirebaseMessaging.onBackgroundMessage(_handleFirebaseBackgroundMessage);
// Get.put(OrbitPushNotificationService(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  final mainHelper = Get.find<MainHelper>();
  @override
  Widget build(BuildContext context) {
    mainHelper.mScreenWidth = MediaQuery.of(context).size.width;

    mainHelper.mScreenHeight = MediaQuery.of(context).size.height;

    return GetMaterialApp(
      getPages: AppRoutes.appRoutes(),
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: AppThemeService().theme,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: BindingsBuilder(() {
        Get.put(
          SplashScreenController(),
        );
      }),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;

  if (isTimeout) {
    BackgroundFetch.finish(taskId);
    return;
  }

  // Reinitialize WebSocket if disconnected
  //WebSocketServices().initializeWebSocket();
  BackgroundFetch.finish(taskId);
}

void initializeBackgroundFetch() {
  BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 15, // 15-minute intervals
      stopOnTerminate: false,
      enableHeadless: true,
    ),
    (String taskId) async {
      WebSocketServices().initializeWebSocket();
      BackgroundFetch.finish(taskId);
    },
    (String taskId) async {
      BackgroundFetch.finish(taskId);
    },
  );

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}
