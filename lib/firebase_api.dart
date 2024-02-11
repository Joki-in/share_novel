import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static int _notificationId = 0; // Menyimpan ID notifikasi terbaru

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification?.title}");
      print("onMessage: ${message.notification?.body}");
      showNotification(
        message.notification?.title ?? 'Default Title',
        message.notification?.body ?? 'Default Body',
        _notificationId++, // Menggunakan ID notifikasi yang berbeda setiap kali
        null,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.title}");
      print("onMessageOpenedApp: ${message.notification?.body}");
    });

    final sharedPreferences = await SharedPreferences.getInstance();
    final fcmToken = await _firebaseMessaging.getToken();
    sharedPreferences.setString('fcmToken', fcmToken ?? '');
    print('FCMtoken: $fcmToken');
  }

  static Future<void> showNotification(String title, String body,
      int notificationId, BuildContext? context) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      // 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId, // Menggunakan ID notifikasi yang diberikan
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
