import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatelessWidget {
  int score = 0;
  List<String> entries = [];
  Function dash;
  List<String> prev = [];
  Result(this.entries, this.dash);

  Future<String> save() async {
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
    //print(entries);
    prefs.setStringList(key, val);
    return getScore();
  }

  String getScore() {
    for (int i = 0; i < entries.length; i++) {
      int x = int.parse(entries[i]);
      score += x;
      //save();
    }

    return score.toString();
  }

  double getDayScore(List<String> a) {
    return ((0.75 * int.parse(a[0])) +
            (0.25 * int.parse(a[1])) +
            (0.25 * int.parse(a[2])) +
            (3 * int.parse(a[3])) +
            (1 * int.parse(a[4])) +
            (1.5 * int.parse(a[5])) +
            (1 * int.parse(a[6])) +
            (1 * int.parse(a[7])) +
            (0.25 * int.parse(a[8]))) /
        9;
  }

  String getAns(List<String> aa) {
    score = 0;
    //print(aa);

    for (int i = 0; i < aa.length; i++) {
      int x = int.parse(aa[i]);
      score += x;
    }
    return score.toString();
  }

  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Column(
      children: <Widget>[
        Text(
          " Today's Score is",
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        FutureBuilder<String>(
            future: save(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(getDayScore(entries).toString());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return (Text("Waiting..."));
              }
              throw 'TODO';
            }),
        RaisedButton(child: Text("Home"), onPressed: dash()),
      ],
    )));
  }
}
