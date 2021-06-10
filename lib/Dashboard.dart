import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'survey.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:math';
import 'dart:async';
import 'quote.dart';
import 'graph.dart';
import 'main.dart';
import 'rules.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createStat
    return DashboardState();
    throw UnimplementedError();
  }
}

List<String> vaa = [];
String weekScore = "0";
String monthScore = "0";
double getDayScore(List<String> a) {
  return ((0.75 * int.parse(a[0])) +
          (0.50 * int.parse(a[1])) +
          (0.25 * int.parse(a[2])) +
          (3 * int.parse(a[3])) +
          (1 * int.parse(a[4])) +
          (1.5 * int.parse(a[5])) +
          (1 * int.parse(a[6])) +
          (1.5 * int.parse(a[7])) +
          (0.50 * int.parse(a[8]))) /
      10;
}

Future<String> read7day() async {
  final prefs = await SharedPreferences.getInstance();
  String cur = "";
  var curDate = DateTime.now();

  int count = 0;
  double curScore = 0;
  for (int i = 0; i < 7; i++) {
    var prev = DateTime.now().subtract(Duration(days: i));
    cur = (prev.year).toString() +
        "-" +
        (prev.month).toString() +
        "-" +
        (prev.day).toString();
    final key = cur;
    vaa = prefs.getStringList(key) ?? ["0"];
    //print(vaa);
    if (vaa.length == 1) {
    } else {
      count++;
      curScore = curScore + getDayScore(vaa);
    }
  }
  //print(count);
  double totalScore = curScore / count;
  totalScore = roundDouble(totalScore, 2);
  weekScore = totalScore.toString();
  return Future.value(weekScore);
  //print(score);
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

Future<String> read30day() async {
  final prefs = await SharedPreferences.getInstance();
  String cur = "";
  var curDate = DateTime.now();

  int count = 0;
  double curScore = 0;
  for (int i = 0; i < 30; i++) {
    var prev = DateTime.now().subtract(Duration(days: i));
    cur = (prev.year).toString() +
        "-" +
        (prev.month).toString() +
        "-" +
        (prev.day).toString();
    final key = cur;
    vaa = prefs.getStringList(key) ?? ["0"];
    //print(vaa);
    if (vaa.length == 1) {
    } else {
      count++;
      curScore = curScore + getDayScore(vaa);
    }
  }
  print(count);
  if (count == 0) return "0";
  double totalScore = curScore / count;
  totalScore = roundDouble(totalScore, 2);
  monthScore = totalScore.toString();
  return Future.value(monthScore);
  //print(score);
}

class DashboardState extends State<Dashboard> {
  void back() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(),
      ),
    );
  }

  void goToRules() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Rules(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Quote(),
            FutureBuilder<String>(
                future: read7day(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Card(
                        child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Week Score",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                height: 33,
                              ),
                              new CircularPercentIndicator(
                                radius: 100.0,
                                lineWidth: 5.0,
                                percent: (double.parse(weekScore) / 10),
                                center: new Text(weekScore),
                                progressColor: Colors.green,
                              ),
                            ],
                          )),
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return (Text("Waiting..."));
                  }
                  throw 'TODO';
                }),
            BarChartSample1(),
            FutureBuilder<String>(
                future: read30day(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                        },
                        child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Month Score",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 300,
                                  height: 33,
                                ),
                                new CircularPercentIndicator(
                                  radius: 100.0,
                                  lineWidth: 5.0,
                                  percent: (double.parse(monthScore) / 10),
                                  center: new Text(monthScore),
                                  progressColor: Colors.green,
                                ),
                              ],
                            )),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return (Text("Waiting..."));
                  }
                  throw 'TODO';
                }),
            ElevatedButton(onPressed: goToRules, child: Text("Rules")),
          ],
        )));
  }
}
