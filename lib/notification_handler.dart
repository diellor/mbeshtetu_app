import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final flutterNotificationPlugin = FlutterLocalNotificationsPlugin();
  static BuildContext _context;

  static void initNotification(BuildContext context) {
    _context = context;
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initIOSSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveNotificationIOs);
    var initSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initIOSSettings);
    flutterNotificationPlugin.initialize(initSettings, onSelectNotification: onSelectNotif);
  }

  static Future onDidRecieveNotificationIOs(int id, String title, String body,
      String payload) {
    showDialog(context: _context, builder: (context) =>
        CupertinoAlertDialog(title: Text(title), content: Text(body), actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(''),
            onPressed: () => Navigator.of(context).pushNamed("/intro"),
          )
        ],));
  }

  static Future onSelectNotif(String payload) {
    if (payload.isNotEmpty) {
      print("EPIC PAYLOAD: $payload");
    }
  }
}
