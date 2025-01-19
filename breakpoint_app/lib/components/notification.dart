import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzData;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initialize();
  }

  Future<void> _initialize() async {
    tzData.initializeTimeZones();

    // Solicitação de permissões no Android 13+
    if (Platform.isAndroid && await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Inicializa o plugin de notificações
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notificação clicada: ${response.payload}');
      },
    );

    // Cria o canal de notificação
    await _createNotificationChannel();

    print('Serviço de notificações inicializado.');
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'main_channel', // ID do canal
      'Notificações principais', // Nome do canal
      description: 'Este canal é usado para notificações principais do app',
      importance: Importance.high,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    print("Canal de notificação criado com sucesso.");
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      // Solicita permissão para notificações
      if (await Permission.notification.isDenied) {
        PermissionStatus status = await Permission.notification.request();
        if (status.isDenied) {
          print(
              "Permissão para notificações foi negada. Por favor, habilite manualmente.");
        }
      }

      // Solicita permissão para alarmes exatos (se necessário)
      if (await Permission.scheduleExactAlarm.isDenied) {
        PermissionStatus status = await Permission.scheduleExactAlarm.request();
        if (status.isDenied) {
          print(
              "Permissão para alarmes exatos foi negada. Por favor, habilite manualmente.");
        }
      }
    }
  }

  Future<void> _scheduleNotification(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledTime,
  ) async {
    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'main_channel', // ID do canal
            'Notificações principais',
            channelDescription: 'Este canal é usado para notificações do app',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      print('Notificação $id agendada com sucesso para $scheduledTime.');
    } catch (e) {
      print('Erro ao agendar a notificação $id: $e');
    }
  }

  Future<void> scheduleNotifications(List<TimeOfDay> times) async {
    await _requestPermissions();

    if (Platform.isAndroid && await Permission.notification.isDenied) {
      print(
          "Permissões necessárias não concedidas. Notificações não serão agendadas.");
      return;
    }

    DateTime now = DateTime.now();

    // Defina o fuso horário do Brasil
    final tz.Location brazilTimeZone = tz.getLocation('America/Sao_Paulo');

    for (int i = 0; i < times.length; i++) {
      TimeOfDay time = times[i];
      DateTime notificationTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      // Se o horário da notificação já passou, agende para o próximo dia
      if (notificationTime.isBefore(now)) {
        notificationTime = notificationTime.add(const Duration(days: 1));
      }

      // Converta para o fuso horário do Brasil
      tz.TZDateTime tzNotificationTime =
          tz.TZDateTime.from(notificationTime, brazilTimeZone);

      await _scheduleNotification(
        i,
        'Alerta de Vício',
        'Lembre-se de evitar situações de risco!',
        tzNotificationTime,
      );
    }
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
    print('Todas as notificações foram canceladas.');
  }

  Future<void> showTestNotification() async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'test_channel',
        'Canal de Teste',
        channelDescription: 'Canal para notificações de teste',
        importance: Importance.max,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
    );

    try {
      await _flutterLocalNotificationsPlugin.show(
        0,
        'Teste de Notificação',
        'Essa é uma notificação de teste!',
        notificationDetails,
      );
      print('Notificação de teste enviada com sucesso.');
    } catch (e) {
      print('Erro ao enviar notificação de teste: $e');
    }
  }
}
