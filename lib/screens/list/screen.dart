import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:simplereminders/bloc/bloc.dart';
import 'package:simplereminders/bloc/state.dart';
import 'package:simplereminders/domain/reminder.dart';
import 'package:simplereminders/mixins/translator.dart';
import 'package:simplereminders/screens/form/screen.dart';

class ListScreen extends StatefulWidget {
  static const String routeName = "list";

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with Translator {
  StreamSubscription _intentDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      if (value != null && value.isNotEmpty) {
        _navigateToFormScreen(title: value);
      }
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    ReceiveSharingIntent.getInitialText().then((String value) {
      if (value != null && value.isNotEmpty) {
        _navigateToFormScreen(title: value);
      }
    });
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("list.title")),
      ),
      body: Center(
          child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.reminders.isEmpty) {
            return _buildNoReminders();
          }

          return _buildReminders(state.reminders);
        },
        bloc: BlocProvider.of<AppBloc>(context),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToFormScreen,
        tooltip: translate("listTooltips.addReminder"),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoReminders() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          translate("list.noReminders"),
        ),
      ],
    );
  }

  Widget _buildReminders(BuiltList<Reminder> reminders) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: reminders.map((reminder) => Text(reminder.toString())).toList(),
    );
  }

  void _navigateToFormScreen({String title = ''}) {
    Navigator.pushNamed(
      context,
      FormScreen.routeName,
      arguments: <String, dynamic>{
        "title": title,
      },
    );
  }
}
