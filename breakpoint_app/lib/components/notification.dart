import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
late AndroidNotificationChannel channel;

class FirebaseApi {
  static final FirebaseApi _instance = FirebaseApi._internal();
  factory FirebaseApi() => _instance;
  FirebaseApi._internal();

  final _firebaseMessaging = FirebaseMessaging.instance;
  bool isFlutterLocalNotificationsInitialized = false;

  // Add initialization settings
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print('Notification tapped: ${details.payload}');
      },
    );

    await setupFlutterNotifications();
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('My token: $fcmToken');

    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(showFlutterNotification);
  }

  Future<void> requestExactAlarmPermissionWithDialog(BuildContext context) async {
  if (Platform.isAndroid) {
    if (await Permission.scheduleExactAlarm.isDenied) {
      bool? shouldOpenSettings = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permissão Necessária'),
          content: const Text(
            'Para notificações precisas, permita alarmes exatos nas configurações do aplicativo.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Ir para Configurações'),
            ),
          ],
        ),
      );

      if (shouldOpenSettings ?? false) {
        await openAppSettings();
      }
    }
  }
}

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  // Função para agendar notificações com base em um vetor de TimeOfDay
  Future<void> scheduleNotifications(List<TimeOfDay> times) async {
    for (TimeOfDay time in times) {
      await _scheduleNotification(time);
    }
  }

  // Função para agendar uma única notificação em um horário específico
  Future<void> _scheduleNotification(TimeOfDay time) async {
    try {
      final now = DateTime.now();
      final localTimeZone = tz.local;
      var scheduledDate = tz.TZDateTime(
        localTimeZone,
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      if (scheduledDate.isBefore(tz.TZDateTime.now(localTimeZone))) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      final uniqueId = time.hour * 60 + time.minute;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        uniqueId,
        'Lembrete',
        'Hora de verificar algo!',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: 'Descrição do canal',
            importance: Importance.high,
            priority: Priority.high,
            showWhen: false,
            icon: '@mipmap/ic_launcher',
            // Add these additional settings
            enableLights: true,
            enableVibration: true,
            playSound: true,
            ticker: 'ticker',
          ),
        ),
        payload: 'notification_${time.hour}_${time.minute}', // Add payload
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.exact,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

// Add method to cancel all notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  // Add method to cancel specific notification
  Future<void> cancelNotification(TimeOfDay time) async {
    final uniqueId = time.hour * 60 + time.minute;
    await flutterLocalNotificationsPlugin.cancel(uniqueId);
  }

  // Add method to check pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}

// Função para mostrar a notificação
void showFlutterNotification(RemoteMessage remoteMessage) {
  print("...onMessage...");
  print("${remoteMessage.notification?.title}");
  print("${remoteMessage.notification?.body}");
  RemoteNotification? notification = remoteMessage.notification;
  AndroidNotification? android = remoteMessage.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

// Função de background message handler
Future<void> handlerBackgroundMessage(RemoteMessage remoteMessage) async {
  print("${remoteMessage.notification?.title}");
  print("${remoteMessage.notification?.body}");
}
