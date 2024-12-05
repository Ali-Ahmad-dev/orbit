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
        autoRunOnMyPackageReplaced: true,
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

  void initializeWebSocket() async {
    await NotificationManager.initialize();
    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((LogRecord rec) {
      print("${rec.level.name}: ${rec.time}: ${rec.message}");
    });

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
    });

    try {
      await _hubConnection?.start();
      print('WebSocket connection established');
    } catch (e) {
      print('Error starting WebSocket connection: $e');
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

    _dataStreamController.stream.listen((data) {
      print('Received data: $data');
    });
  }

  Future<void> startService(String title, String message) async {
    await _requestPermissions();

    // Start the foreground service with dynamic title and message
    FlutterForegroundTask.startService(
      serviceId: 256,
      notificationTitle: title, // Use the actual title from WebSocket
      notificationText: message, // Use the actual message from WebSocket
      notificationIcon: null,
      notificationButtons: [
        const NotificationButton(id: 'btn_hello', text: 'hello'),
      ],
      notificationInitialRoute: '/',
      callback: startCallback,
    );
  }

  @pragma('vm:entry-point')
  void startCallback() {
    FlutterForegroundTask.setTaskHandler(FirstTaskHandler());
  }

  void dispose() {
    _dataStreamController.close();
    _hubConnection?.stop();
  }
}

// Define the FirstTaskHandler outside WebSocketServices
class FirstTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // Start the WebSocket service here or manage ongoing WebSocket connection.
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // Perform repeated task logic
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // Cleanup or stop the service
  }
}