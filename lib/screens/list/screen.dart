import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:simplereminders/screens/form/screen.dart';

class ListScreen extends StatefulWidget {
  static const String route = "list";

  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No reminders configured yet.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToFormScreen,
        tooltip: 'Add new reminder',
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToFormScreen() {
    Navigator.pushNamed(context, FormScreen.route);
  }
}
