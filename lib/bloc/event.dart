import 'package:equatable/equatable.dart';
import 'package:simplereminders/domain/reminder.dart';

abstract class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class AppStarted extends Event {}

class RemindersLoaded extends Event {
  final List<Reminder> reminders;

  RemindersLoaded(this.reminders);

  @override
  List<Object> get props => [reminders];
}
