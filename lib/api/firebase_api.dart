import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification?.title}');
  print('Body : ${message.notification?.body}');
  print('Payload : ${message.data}');
  final DateTime now = DateTime.now();
  final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  final String formattedTime = DateFormat('HH:mm:ss').format(now);
  await FirebaseApi().saveNotification(message.notification?.title ?? "",
      message.notification?.body ?? "", formattedDate, formattedTime);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('Notifications');
  Future<void> saveNotification(String title, String body, String formattedDate,
      String formattedTime) async {
    await _databaseReference.push().set({
      'title': title,
      'body': body,
      'formattedDate': formattedDate,
      'formattedTime': formattedTime,
      'timestamp': ServerValue.timestamp, // Additional timestamp for sorting
    });
  }

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notification',
      description: 'This channel is used for assist app notifications',
      importance: Importance.high);
  String? currentFcmToken;

  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    currentFcmToken = await _firebaseMessaging.getToken();
    print('FCM Token : $currentFcmToken');
    initLocalNotifications();

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      final DateTime now = DateTime.now();
      final String formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final String formattedTime = DateFormat('HH:mm:ss').format(now);
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                importance: Importance.high,
                icon: '@drawable/launcher_icon'),
          ),
          payload: jsonEncode(event.toMap()));

      // Ajouter la notification dans la base de données Firebase Realtime
      saveNotification(notification.title ?? "", notification.body ?? "",
          formattedDate, formattedTime);
    });
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings('@drawable/launcher_icon');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleBackgroundMessage(message);
    });
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }
}
