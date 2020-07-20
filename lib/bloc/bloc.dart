import 'package:bloc/bloc.dart';
import 'package:simplereminders/bloc/state.dart';
import 'package:simplereminders/bloc/event.dart';

class MainBloc extends Bloc<Event, State> {
  MainBloc() : super(State(isLoading: true));

  @override
  Stream<State> mapEventToState(Event event) async* {
    if (event is AppStarted) {
      yield state.setLoading();
    }

    if (event is RemindersLoaded) {
      yield state.setLoaded();
    }
  }
}
