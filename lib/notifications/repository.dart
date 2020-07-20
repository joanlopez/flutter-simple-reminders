import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simplereminders/domain/reminder.dart';
import 'package:simplereminders/domain/notification.dart';
import 'package:simplereminders/notifications/notifications.dart';

class NotificationsRepository implements Repository {
  final NotificationsProvider notificationsProvider;

  NotificationsRepository(this.notificationsProvider)
      : assert(notificationsProvider != null);

  @override
  Future<List<Reminder>> fetchReminders() async {
    List<PendingNotificationRequest> notifications =
        await notificationsProvider.get();

    return notifications
        .map((n) => Reminder(Notification(n.id, n.title, n.body, n.payload)))
        .toList();
  }
}
