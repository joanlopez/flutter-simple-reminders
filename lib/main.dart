import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:simplereminders/bloc/bloc.dart';
import 'package:simplereminders/bloc/observer.dart';
import 'package:simplereminders/screens/form/screen.dart';
import 'package:simplereminders/screens/list/screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  LocalizationDelegate.create(
          fallbackLocale: 'en', supportedLocales: ['en', 'es'])
      .then((delegate) => runApp(LocalizedApp(delegate, SimpleRemindersApp())));
}

class SimpleRemindersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (_) => MainBloc(),
      child: MaterialApp(
        title: 'Simple Reminders',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: ListScreen.route,
        routes: {
          ListScreen.route: (context) => ListScreen(),
          FormScreen.route: (context) => FormScreen(),
        },
      ),
    );
  }
}
