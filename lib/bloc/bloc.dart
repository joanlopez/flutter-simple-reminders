import 'package:bloc/bloc.dart';
import 'package:simplereminders/bloc/state.dart';
import 'package:simplereminders/bloc/event.dart';
import 'package:simplereminders/domain/reminder.dart';

class MainBloc extends Bloc<Event, State> {
  final Repository repository;

  MainBloc(this.repository)
      : assert(repository != null),
        super(State(isLoading: true));

  @override
  Stream<State> mapEventToState(Event event) async* {
    if (event is AppStarted) {
      repository.fetchReminders().then((reminders) {
        add(RemindersLoaded(reminders));
      });

      yield state.setLoading();
    }

    if (event is RemindersLoaded) {
      yield state.setLoaded(event.reminders);
    }
  }
}
