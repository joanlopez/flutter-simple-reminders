import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:simplereminders/domain/reminder.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

class RemindersLoaded extends AppEvent {
  final BuiltList<Reminder> reminders;

  RemindersLoaded(this.reminders);

  @override
  List<Object> get props => [reminders];
}

class ReminderAdded extends AppEvent {
  final Reminder reminder;

  ReminderAdded(this.reminder);

  @override
  List<Object> get props => [reminder];
}
