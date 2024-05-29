import 'dart:developer';
import 'dart:math';

import 'package:adalato_app/models/tips_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  final CollectionReference _tipsCollectionRef =
  FirebaseFirestore.instance.collection('tips');

  List<TipModel> tips = [];



  @override
  void initState() {
    fetchTipsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final tip = getRandomTip();


    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Tip'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tip.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              tip.description,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to get a random tip from the list using the tip's ID
  TipModel getRandomTip() {
    final random = Random();
    int randomId = random.nextInt(tips.length) +
        1; // +1 to ensure it's between 1 and length
    String randomS = randomId.toString();
    return tips[randomId];
      //tips.firstWhere((tip) => tip.tipId == randomS);
  }

  Future<void> fetchTipsList() async {

    try {
      QuerySnapshot querySnapshot = await _tipsCollectionRef.get();

      setState(() {
        tips = querySnapshot.docs
            .map((doc) => TipModel.fromDocument(doc))
            .toList();

      });
    } catch (e) {



    }
  }
}
