import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereminders/bloc/bloc.dart';
import 'package:simplereminders/bloc/event.dart';
import 'package:simplereminders/domain/reminder.dart';
import 'package:simplereminders/mixins/translator.dart';
import 'package:simplereminders/mixins/map.dart';
import 'package:simplereminders/screens/form/widgets/datetime_row.dart';

class FormScreen extends StatefulWidget {
  static const String routeName = "form";

  final FirebaseAnalytics analytics;

  FormScreen({Key key, this.analytics})
      : assert(analytics != null),
        super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> with Translator {
  final _formKey = GlobalKey<FormState>();
  final _dateTimeRowKey = GlobalKey<DateTimeRowState>();

  TextEditingController titleTextController;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;

    titleTextController =
        TextEditingController(text: args.getOrElse("title", ""));

    return Scaffold(
      appBar: AppBar(
        title: Text(translate("form.title")),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildTitleInput(),
              DateTimeRow(key: _dateTimeRowKey),
              buildSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTitleInput() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 70.0),
      child: TextFormField(
        controller: titleTextController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: translate('form.reminderTitle'),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return translate("form.emptyTitle");
          }
          return null;
        },
      ),
    );
  }

  Padding buildSubmit() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            dispatchReminderAddedEvent();
            logReminderAddedAnalyticsEvent();
            Navigator.pop(context);
          }
        },
        child: Text(translate("form.add")),
      ),
    );
  }

  void dispatchReminderAddedEvent() {
    BlocProvider.of<AppBloc>(context)
      ..add(
        ReminderAdded(Reminder(
          title: titleTextController.text.toString(),
          scheduledAt: _dateTimeRowKey.currentState.currentDateTime(),
        )),
      );
  }

  void logReminderAddedAnalyticsEvent() {
    widget.analytics.logEvent(
      name: 'reminder_added',
      parameters: <String, dynamic>{
        'title': titleTextController.text.toString(),
        'scheduledAt': _dateTimeRowKey.currentState
            .currentDateTime()
            .millisecondsSinceEpoch,
      },
    );
  }
}
