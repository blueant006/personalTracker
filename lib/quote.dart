import 'package:flutter/material.dart';
import 'dart:math';

List<String> quotes = [
  "The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela",
  "The way to get started is to quit talking and begin doing. -Walt Disney",
  "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking.-Steve Jobs",
  "If life were predictable it would cease to be life, and be without flavor. -Eleanor Roosevelt",
  "If you look at what you have in life, you'll always have more. If you look at what you don't have in life, you'll never have enough. -Oprah Winfrey"
      "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success. -James Cameron",
  "An investment in knowledge pays the best interest. — Benjamin Franklin",
  "I will tell you how to become rich. Close the doors. Be fearful when others are greedy. Be greedy when others are fearful. — Warren Buffett",
  "Life is what happens when you're busy making other plans. -John Lennon",
  "When you reach the end of your rope, tie a knot in it and hang on. -Franklin D. Roosevelt",
  "The only impossible journey is the one you never begin. -Tony Robbins"
];
int m = quotes.length;
Random random = new Random();
int rand = random.nextInt(100);

class Quote extends StatelessWidget {
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
