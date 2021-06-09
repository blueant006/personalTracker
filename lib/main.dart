import 'package:flutter/material.dart';
import 'section.dart';
import 'option.dart';
import 'result.dart';
import 'Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'Personal Tracker',
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
    throw UnimplementedError();
  }
}

class _MainPageState extends State<MainPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Tracker"),
      ),
      body: Dashboard(),
    );
  }
}
