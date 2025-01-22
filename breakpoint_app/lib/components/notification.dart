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

  // Adiciona inicialização padrão
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  static const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  Future<void> initNotification() async {
    await checkPermissions(); // Verificar permissões
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print('Notificação tocada: ${details.payload}');
      },
    );

    await setupFlutterNotifications();
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print('Meu token: $fcmToken');

    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMessage);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(showFlutterNotification);
  }

  Future<void> checkPermissions() async {
    var notificationStatus = await Permission.notification.status;
    if (notificationStatus.isDenied) {
      print("Permissão de notificação negada.");
      var result = await Permission.notification.request();
      if (result.isGranted) {
        print("Permissão de notificação concedida.");
      } else {
        print("Permissão de notificação ainda negada.");
      }
    } else if (notificationStatus.isGranted) {
      print("Permissão de notificação já concedida.");
    }

    var alarmStatus = await Permission.scheduleExactAlarm.status;
    if (alarmStatus.isDenied) {
      print("Permissão para alarmes exatos negada. Abrindo configurações.");
      await openAppSettings();
    } else if (alarmStatus.isGranted) {
      print("Permissão para alarmes exatos já concedida.");
    }
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
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

  Future<void> scheduleNotifications(List<TimeOfDay> times) async {
    for (TimeOfDay time in times) {
      await _scheduleNotification(time);
    }
  }

  Future<void> _scheduleNotification(TimeOfDay time) async {
    try {
      final now = DateTime.now();
      final localTimeZone = tz.getLocation('America/Sao_Paulo');
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
            importance: Importance.high,
            priority: Priority.high,
            showWhen: false,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: 'notification_${time.hour}_${time.minute}',
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
        androidScheduleMode: AndroidScheduleMode.exact,
      );
      print('Notificação agendada para $scheduledDate');
    } catch (e) {
      print('Erro ao agendar notificação: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}

void showFlutterNotification(RemoteMessage remoteMessage) {
  try {
    print("Recebendo mensagem...");
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
  } catch (e) {
    print("Erro ao exibir notificação em primeiro plano: $e");
  }
}

Future<void> handlerBackgroundMessage(RemoteMessage remoteMessage) async {
  try {
    print("Mensagem recebida em segundo plano: ${remoteMessage.notification?.title}");
  } catch (e) {
    print("Erro ao processar mensagem de segundo plano: $e");
  }
}

