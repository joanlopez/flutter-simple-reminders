import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:simplereminders/bloc/bloc.dart';
import 'package:simplereminders/bloc/event.dart';
import 'package:simplereminders/bloc/observer.dart';
import 'package:simplereminders/notifications/notifications.dart';
import 'package:simplereminders/notifications/repository.dart';
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
    NotificationsProvider provider = NotificationsProvider();
    NotificationsRepository repository = NotificationsRepository(provider);

    return BlocProvider<AppBloc>(
      // By default, BlocProvider will create the bloc lazily, meaning create
      // will get executed when the bloc is looked up via BlocProvider.of(context).
      // To override this behavior and force create to be run immediately,
      // lazy can be set to false.
      lazy: false,
      create: (BuildContext context) => AppBloc(repository)..add(AppStarted()),
      child: MaterialApp(
        title: 'Simple Reminders',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('es', ''), // Spanish, no country code
        ],
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
