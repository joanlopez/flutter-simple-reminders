import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsProvider {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings _androidInitializationSettings;
  IOSInitializationSettings _iosInitializationSettings;
  InitializationSettings _initializationSettings;

  NotificationsProvider() {
    _setUp();
  }

  schedule(DateTime scheduledDate) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            "channelId", "channelName", "channelDescription",
            priority: Priority.High,
            importance: Importance.Max,
            ticker: "ticker");

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    await _flutterLocalNotificationsPlugin.schedule(0, "Simple Reminder Title",
        "Simple Reminder Payload", scheduledDate, notificationDetails,
        androidAllowWhileIdle: true);
  }

  Future<List<PendingNotificationRequest>> get() async {
    return _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  _setUp() async {
    _androidInitializationSettings =
        AndroidInitializationSettings("ic_launcher");
    _iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    _initializationSettings = InitializationSettings(
        _androidInitializationSettings, _iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    // Do whatever you want
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            /* Do whatever you want */
          },
          child: Text("Okay"),
        )
      ],
    );
  }
}
