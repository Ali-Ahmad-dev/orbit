import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/services/local_notification.dart';
import 'package:orbit/utils/shared_prefrences.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class WebSocketServices {
  final _dataStreamController = StreamController<dynamic>.broadcast();
  HubConnection? _hubConnection;

  WebSocketServices() {
    _initService();
    initializeWebSocket();
  }

  void _initService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<void> _requestPermissions() async {
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
      }

      if (!await FlutterForegroundTask.canScheduleExactAlarms) {
        await FlutterForegroundTask.openAlarmsAndRemindersSettings();
      }
    }
  }

  Future<void> initializeWebSocket() async {
    await NotificationManager.initialize();
    const serverUrl = NetworkEndpoints.webSocketUrl;

    final httpOptions = HttpConnectionOptions(
      transport: HttpTransportType.WebSockets,
      requestTimeout: 60000,
    );

    _hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl, options: httpOptions)
        .withAutomaticReconnect()
        .build();

    _hubConnection?.onclose(({error}) {
      print('WebSocket closed. Error: $error');
      reconnect(); // Reconnect on closure
    });

    try {
      await _hubConnection?.start();
      print('WebSocket connection established');
    } catch (e) {
      print('Error starting WebSocket connection: $e');
      reconnect();
    }

    _hubConnection?.on('ReceiveMessage', (List? arguments) async {
      Map<dynamic, dynamic> formattedData =
          jsonDecode(arguments![1].toString());
      int? storedId = await SharedPrefs.getEmployeeId();

      if (storedId == int.parse(arguments[0])) {
        await NotificationManager.showNotification(
            formattedData["Title"], formattedData["Message"]);
        await startService(formattedData["Title"], formattedData["Message"]);
      }
    });
  }

  void reconnect() {
    Future.delayed(const Duration(seconds: 10), () {
      initializeWebSocket();
    });
  }

  Future<void> startService(String title, String message) async {
    await _requestPermissions();
    FlutterForegroundTask.startService(
      serviceId: 256,
      notificationTitle: title,
      notificationText: message,
      notificationIcon: null,
    );
  }

  void dispose() {
    _dataStreamController.close();
    _hubConnection?.stop();
  }
}
