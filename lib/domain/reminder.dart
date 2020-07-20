import 'package:simplereminders/domain/notification.dart';

class Reminder {
  final Notification notification;

  const Reminder(this.notification);
}

abstract class Repository {
  Future<List<Reminder>> fetchReminders();
}
