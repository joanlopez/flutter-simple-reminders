import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:simplereminders/bloc/state.dart';
import 'package:simplereminders/bloc/event.dart';
import 'package:simplereminders/domain/reminder.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final Repository repository;

  AppBloc(this.repository)
      : assert(repository != null),
        super(AppState(isLoading: true, reminders: BuiltList()));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppStarted) {
      repository.fetchReminders().then((reminders) {
        add(RemindersLoaded(BuiltList.from(reminders)));
      });

      yield state.setLoading();
    }

    if (event is RemindersLoaded) {
      yield state.setLoaded(event.reminders);
    }

    if (event is ReminderAdded) {
      await repository.scheduleReminder(event.reminder);
      yield state.addReminder(event.reminder);
    }
  }
}
