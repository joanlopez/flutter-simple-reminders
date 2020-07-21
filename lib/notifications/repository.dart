import 'package:built_collection/built_collection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simplereminders/domain/reminder.dart';
import 'package:simplereminders/domain/notification.dart';
import 'package:simplereminders/notifications/notifications.dart';

class NotificationsRepository implements Repository {
  final NotificationsProvider notificationsProvider;

  NotificationsRepository(this.notificationsProvider)
      : assert(notificationsProvider != null);

  @override
  Future<void> scheduleReminder(Reminder reminder) {
    return notificationsProvider.schedule(reminder.scheduledAt, reminder.title);
  }

  @override
  Future<BuiltList<Reminder>> fetchReminders() async {
    List<PendingNotificationRequest> notifications =
        await notificationsProvider.get();

    DateTime now = DateTime.now();

    return BuiltList.from(notifications
        .where((n) => DateTime.parse(n.payload).isAfter(now))
        .map((n) => Reminder.hydrate(n.title, DateTime.parse(n.payload),
            Notification(n.id, n.title, n.body, n.payload)))
        .toList());
  }
}
