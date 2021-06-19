import 'package:flutter/material.dart';
import 'package:my_first_app/homeScreen.dart';
import 'package:my_first_app/main.dart';
import 'section.dart';
import 'option.dart';
import 'result.dart';
import 'Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySurvey extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MySurveyState();
    throw UnimplementedError();
  }
}

class _MySurveyState extends State<MySurvey> {
  int qIndex = 0;
  List<String> entries = [];
  var questions = [
    {
      "t": "Diet",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Excercise",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Sleep",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Study/Work",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Hobbies",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Finance",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Concentration",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Satisfaction",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
    {
      "t": "Peer Behavior",
      "Options": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    },
  ];
  void fun(String x) {
    //print("Answer Chosen");
    entries.add(x);
    setState(() {
      qIndex = qIndex + 1;
    });
  }

  int score = 0;
  List<String> vaa = [];
  save() async {
    final prefs = await SharedPreferences.getInstance();
    String cur = "";
    var curDate = DateTime.now();
    cur = (curDate.year).toString() +
        "-" +
        (curDate.month).toString() +
        "-" +
        (curDate.day).toString();
    final key = cur;
    // print(key);
    List<String> val = entries;
    prefs.setStringList(key, val);
  }

  void dash() {
    //print("ad");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: qIndex < questions.length
                ? Column(
                    children: <Widget>[
                      Section(questions[qIndex]['t'].toString()),
                      ...(questions[qIndex]["Options"] as List<String>)
                          .map((answer) {
                        return Option(() => fun(answer), answer);
                      }).toList(),
                    ],
                  )
                : Result(entries, () => dash())));
    throw UnimplementedError();
  }
}
