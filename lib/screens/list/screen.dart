import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simplereminders/mixins/translator.dart';
import 'package:simplereminders/screens/form/screen.dart';

class ListScreen extends StatefulWidget {
  static const String route = "list";

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with Translator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("list.title")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              translate("list.noReminders"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToFormScreen,
        tooltip: translate("listTooltips.addReminder"),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToFormScreen() {
    Navigator.pushNamed(context, FormScreen.route);
  }
}
