import 'package:equatable/equatable.dart';
import 'package:simplereminders/domain/reminder.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

class RemindersLoaded extends AppEvent {
  final List<Reminder> reminders;

  RemindersLoaded(this.reminders);

  @override
  List<Object> get props => [reminders];
}
