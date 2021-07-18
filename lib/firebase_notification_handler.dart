import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_handler.dart';

class FirebaseNotificationHandler {
  FirebaseMessaging _messaging;
  BuildContext _context;

  void setupFirebaseMessaging(BuildContext context) {
    _context = context;
    _messaging = FirebaseMessaging.instance;
    NotificationHandler.initNotification(context);
    firebaseMessageListener(_context);
  }

  void firebaseMessageListener(BuildContext context) async {
    NotificationSettings notificationSettings =
        await _messaging.requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            criticalAlert: false,
            provisional: false,
            sound: true);
    print("Settings: $notificationSettings");
    FirebaseMessaging.onMessage.listen((event) {
      print("MESSAGE: $event");
      showNotification(event.notification.title, event.notification.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showDialog(
          context: _context,
          builder: (context) => CupertinoAlertDialog(
                title: Text(event.notification.title),
                content: Text(event.notification.body),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text(''),
                    onPressed: () => Navigator.of(context).pushNamed("/intro"),
                  )
                ],
              ));
    });
  }

  void showNotification(String title, String body) async {
    const AndroidNotificationDetails channel = AndroidNotificationDetails(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        'This channel is used for important notifications.', // description
        importance: Importance.max,
        autoCancel: false,
        priority: Priority.high,
        ongoing: true);
    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();
    var details =
        NotificationDetails(android: channel, iOS: iosNotificationDetails);
    await NotificationHandler.flutterNotificationPlugin
        .show(999, title, body, details);
  }
}
