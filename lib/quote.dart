import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Quote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference quotes =
        FirebaseFirestore.instance.collection('quotes');
    final String documentId = "SxMS1uCgDVe3HH1AY6Qp";
    Random random = new Random();
    int ind = random.nextInt(10);
    return FutureBuilder<DocumentSnapshot>(
      future: quotes.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;

          return Container(
            child: Text(
              "${data['quoteList'][ind]} ",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            margin: const EdgeInsets.all(10.0),
            width: double.infinity,
          );
        }

        return Text("loading");
      },
    );
  }
}
