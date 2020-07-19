import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplereminders/screens/list/screen.dart';

void main() {
  testWidgets('List contains no reminders after initialization', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    Widget toTest = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: ListScreen()),
    );

    await tester.pumpWidget(toTest);

    // Verify that there are no reminders.
    expect(find.text('list.noReminders'), findsOneWidget);
  });
}
