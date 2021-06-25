import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;
  List<String> vaa = [];
  String weekScore = "";
  List<int> days = [];
  List<double> scores = [];

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 10,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  var dayMap = {
    "Monday": 0,
    "Tuesday": 1,
    "Wednesday": 2,
    "Thursaday": 3,
    "Friday": 4,
    "Sataurday": 5,
    "Sunday": 6
  };
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

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places).toDouble();
    return ((value * mod).round().toDouble() / mod);
  }

  Future<String> read7day() async {
    final prefs = await SharedPreferences.getInstance();
    String cur = "";
    var curDate = DateTime.now();

    int count = 0;
    double curScore = 0;
    for (int i = 6; i >= 0; i--) {
      var prev = DateTime.now().subtract(Duration(days: i));
      cur = (prev.year).toString() +
          "-" +
          (prev.month).toString() +
          "-" +
          (prev.day).toString();
      var key = cur;
      int day = prev.weekday;
      days.add(day - 1);
      vaa = prefs.getStringList(key) ?? ["0"];
      //print(vaa);
      if (vaa.length == 1) {
        scores.add(0);
      } else {
        count++;
        curScore = curScore + getDayScore(vaa);
        scores.add(getDayScore(vaa));
      }
    }
    //print(scores);
    double totalScore = curScore / count;
    totalScore = roundDouble(totalScore, 2);
    weekScore = totalScore.toString();

    return Future.value(weekScore);
    //print(score);
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> ans = [];
    //read7day();
    for (int i = 0; i < 7; i++) {
      ans.add(makeGroupData(days[i], scores[i], isTouched: i == touchedIndex));
    }
    return ans;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: null,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<String>(
            future: read7day(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: const Color(0xff81e5cd),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Weekly graph',
                                style: TextStyle(
                                    color: const Color(0xff0f4a3c),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: BarChart(
                                    mainBarData(),
                                    swapAnimationDuration: animDuration,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Wating...");
              }
              throw 'TODO';
            }));
  }
}
