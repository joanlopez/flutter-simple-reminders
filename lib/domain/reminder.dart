import 'dart:io';
import 'dart:math';
import 'package:built_collection/built_collection.dart';
import 'package:intl/intl.dart';
import 'package:simplereminders/domain/notification.dart';

class Reminder {
  static const int maxId = 9999999;

  final String title;
  final DateTime scheduledAt;
  Notification notification;

  Reminder({this.title, this.scheduledAt})
      : assert(title != null && title != ""),
        assert(scheduledAt != null && scheduledAt.isAfter(DateTime.now())) {
    this.notification = Notification(_generateId(), title, "", "");
  }

  Reminder.hydrate(this.title, this.scheduledAt, this.notification)
      : assert(title != null && title != ""),
        assert(scheduledAt != null && scheduledAt.isAfter(DateTime.now())),
        assert(notification != null);

  @override
  String toString() {
    String at = DateFormat.yMMMEd(Platform.localeName).add_Hm().format(scheduledAt);
    return "$title @ $at";
  }

  int _generateId() {
    return Random.secure().nextInt(maxId);
  }
}

abstract class Repository {
  Future<void> scheduleReminder(Reminder reminder);

  Future<BuiltList<Reminder>> fetchReminders();
}
