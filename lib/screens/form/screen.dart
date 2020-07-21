import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplereminders/bloc/bloc.dart';
import 'package:simplereminders/bloc/event.dart';
import 'package:simplereminders/domain/reminder.dart';
import 'package:simplereminders/mixins/translator.dart';
import 'package:simplereminders/screens/form/widgets/datetime_row.dart';

class FormScreen extends StatefulWidget {
  static const String route = "form";

  FormScreen({Key key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> with Translator {
  final _formKey = GlobalKey<FormState>();
  final _dateTimeRowKey = GlobalKey<DateTimeRowState>();

  TextEditingController titleTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
}
