import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  Notifications._internal();
  static final _instance = Notifications._internal();
  static Notifications get instance => _instance;

  final notifications = FlutterLocalNotificationsPlugin();

  final settings = const InitializationSettings(
    android: AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    ),
  );
  final details = const NotificationDetails(
    android: AndroidNotificationDetails(
      'zencillo_notifications',
      'zencillo_notification_channel',
      channelDescription: 'Notifications for com.zencillo.pos_mobile',
      importance: Importance.max,
      priority: Priority.max,
    ),
  );

  Future<void> init() async {
    if (Platform.isAndroid) {
      await notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }
    await notifications.initialize(settings);
  }

  Future<void> show({required String title, required String body}) async {
    await notifications.show(0, title, body, details);
  }
}
