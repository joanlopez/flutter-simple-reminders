import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:simplereminders/domain/reminder.dart';

class AppState extends Equatable {
  final bool isLoading;
  final BuiltList<Reminder> reminders;

  AppState({this.isLoading = false, this.reminders})
      : assert(isLoading != null),
        assert(reminders != null);

  @override
  List<Object> get props => [isLoading, reminders];

  AppState setLoaded([BuiltList<Reminder> reminders]) {
    return _copyWith(isLoading: false, reminders: reminders ?? []);
  }

  AppState setLoading() {
    return _copyWith(isLoading: true);
  }

  AppState addReminder(Reminder reminder) {
    return _copyWith(reminders: reminders.rebuild((b) => b.add(reminder)));
  }

  AppState _copyWith({
    bool isLoading,
    BuiltList<Reminder> reminders,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      reminders: reminders ?? this.reminders,
    );
  }
}
