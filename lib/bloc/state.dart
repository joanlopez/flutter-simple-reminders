import 'package:equatable/equatable.dart';
import 'package:simplereminders/domain/reminder.dart';

class State extends Equatable {
  final bool isLoading;
  final List<Reminder> reminders;

  State({this.isLoading = false, this.reminders = const []})
      : assert(isLoading != null),
        assert(reminders != null);

  @override
  List<Object> get props => [isLoading, reminders];

  State setLoaded([List<Reminder> reminders]) {
    return _copyWith(isLoading: false, reminders: reminders ?? []);
  }

  State setLoading() {
    return _copyWith(isLoading: true);
  }

  State addReminder(Reminder reminder) {
    reminders.add(reminder);

    return _copyWith(reminders: reminders);
  }

  State _copyWith({
    bool isLoading,
    List<Reminder> reminders,
  }) {
    return State(
      isLoading: isLoading ?? this.isLoading,
      reminders: reminders ?? this.reminders,
    );
  }
}
