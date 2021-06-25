import 'package:flutter/material.dart';
import 'dart:math';

List<String> quotes = [
  "The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela",
  "The way to get started is to quit talking and begin doing. -Walt Disney",
  "If life were predictable it would cease to be life, and be without flavor. -Eleanor Roosevelt",
  "An investment in knowledge pays the best interest. — Benjamin Franklin",
  "Life is what happens when you're busy making other plans. -John Lennon",
  "When you reach the end of your rope, tie a knot in it and hang on. -Franklin D. Roosevelt",
  "The only impossible journey is the one you never begin. -Tony Robbins",
  "Don’t Let Yesterday Take Up Too Much Of Today.” – Will Rogers",
  "“Knowing Is Not Enough; We Must Apply. Wishing Is Not Enough; We Must Do.” – Johann Wolfgang Von Goethe",
  "“We Generate Fears While We Sit. We Overcome Them By Action.” – Dr. Henry Link",
  "“Creativity Is Intelligence Having Fun.” – Albert Einstein",
  ") “Do What You Can With All You Have, Wherever You Are.” – Theodore Roosevelt",
];
int m = quotes.length;
Random random = new Random();
int rand = random.nextInt(100);

class QuoteOffline extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        quotes[rand % m],
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
      margin: const EdgeInsets.all(10.0),
      width: double.infinity,
    );
  }
}
