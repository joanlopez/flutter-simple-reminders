import 'package:equatable/equatable.dart';
import 'package:simplereminders/domain/reminder.dart';

class AppState extends Equatable {
  final bool isLoading;
  final List<Reminder> reminders;

  AppState({this.isLoading = false, this.reminders = const []})
      : assert(isLoading != null),
        assert(reminders != null);

  @override
  List<Object> get props => [isLoading, reminders];

  AppState setLoaded([List<Reminder> reminders]) {
    return _copyWith(isLoading: false, reminders: reminders ?? []);
  }

  AppState setLoading() {
    return _copyWith(isLoading: true);
  }

  AppState addReminder(Reminder reminder) {
    reminders.add(reminder);

    return _copyWith(reminders: reminders);
  }

  AppState _copyWith({
    bool isLoading,
    List<Reminder> reminders,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      reminders: reminders ?? this.reminders,
    );
  }
}
