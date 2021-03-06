import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';
import 'package:simplereminders/mixins/translator.dart';

class DateTimeRow extends StatefulWidget {
  static const tenMinutes = Duration(minutes: 10);

  DateTimeRow({Key key}) : super(key: key);

  @override
  DateTimeRowState createState() {
    return DateTimeRowState();
  }
}

class DateTimeRowState extends State<DateTimeRow> with Translator {
  DateTime date;
  DateFormat dateFormat;

  TimeOfDay time;
  DateFormat timeFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    date = DateTime.now();
    dateFormat = DateFormat.yMMMEd(Platform.localeName);

    time = currentTimePlusTenMinutes();
    timeFormat = DateFormat.Hm(Platform.localeName);
  }

  DateTime currentDateTime() {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  TimeOfDay currentTimePlusTenMinutes() {
    DateTime nowPlusTenMinutes = date.add(DateTimeRow.tenMinutes);
    return TimeOfDay(
        hour: nowPlusTenMinutes.hour, minute: nowPlusTenMinutes.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
            onTap: _pickDate,
            child: Card(
                color: Colors.transparent,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        Text(translate("form.date"),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        Text(dateFormat.format(date)),
                      ],
                    )),
                elevation: 0.0)),
        GestureDetector(
            onTap: _pickTime,
            child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(),
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(translate("form.time"),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.0),
                        Text(timeFormat.format(_timeOfDayToDateTime(time))),
                      ],
                    )),
                elevation: 0.0)),
      ],
    );
  }

  void _pickDate() async {
    DateTime newDate = await showDatePicker(
      context: context,
      helpText: translate("form.selectDate"),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: date,
    );

    if (newDate != null)
      setState(() {
        date = newDate;
      });
  }

  void _pickTime() async {
    TimeOfDay newTime =
        await showTimePicker(context: context, initialTime: time);

    if (newTime != null)
      setState(() {
        time = newTime;
      });
  }

  DateTime _timeOfDayToDateTime(TimeOfDay tod) {
    final now = new DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }
}
