import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simplereminders/bloc/bloc.dart';
import 'package:simplereminders/bloc/event.dart';
import 'package:simplereminders/domain/reminder.dart';
import 'package:simplereminders/screens/list/screen.dart';

void main() {
  testWidgets("List contains no reminders after initialization",
      (WidgetTester tester) async {
    // GIVEN a repository that returns an empty list of reminders
    var mockRepository = buildRepositoryMock(BuiltList());

    // WHEN the ListScreen is built
    AppBloc bloc = AppBloc(mockRepository);
    Widget toTest = buildWidgetToTest(bloc);
    await tester.pumpWidget(toTest);
    await tester.pump(Duration(seconds: 5));

    // THEN it shows the noReminders copy
    expect(find.text("list.noReminders"), findsOneWidget);
  });

  testWidgets("List shows the stored reminders", (WidgetTester tester) async {
    // GIVEN a repository that returns a list of reminders
    var reminders = BuiltList<Reminder>([
      buildReminder("Reminder One"),
      buildReminder("Reminder Two"),
    ]);

    // WHEN the ListScreen is built
    AppBloc bloc = AppBloc(buildRepositoryMock(reminders));
    Widget toTest = buildWidgetToTest(bloc);
    await tester.pumpWidget(toTest);
    await tester.pump(Duration(seconds: 5));

    // THEN it shows the reminders
    expect(find.text("list.noReminders"), findsNothing);
    reminders.forEach((reminder) {
      expect(find.text(reminder.toString()), findsOneWidget);
    });
  });
}

Widget buildWidgetToTest(AppBloc bloc) {
  return MediaQuery(
    data: new MediaQueryData(),
    child: BlocProvider<AppBloc>(
      create: (BuildContext context) => bloc..add(AppStarted()),
      child: MaterialApp(home: ListScreen()),
    ),
  );
}

Repository buildRepositoryMock(BuiltList<Reminder> reminders) {
  var mock = MockRepository();
  when(mock.fetchReminders())
      .thenAnswer((_) => Future<BuiltList<Reminder>>.value(reminders));

  return mock;
}

Reminder buildReminder(String title) {
  return Reminder(
    title: title,
    scheduledAt: DateTime.now().add(Duration(minutes: 5)),
  );
}

class MockRepository extends Mock implements Repository {}
