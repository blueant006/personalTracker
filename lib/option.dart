import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final Function x;
  final String text;
  Option(this.x, this.text);
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        onPressed: x,
        color: Colors.amber,
      ),
    );
  }
}
