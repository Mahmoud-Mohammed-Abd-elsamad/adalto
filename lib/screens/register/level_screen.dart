import 'package:adalato_app/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FitnessLevelScreen extends StatefulWidget {
  @override
  _FitnessLevelScreenState createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  String _selectedLevel = '';

  void _selectLevel(String level) {
    setState(() {
      _selectedLevel = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Fitness Level',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildLevelCard('Beginner',
                'Some experience                                                '),
            _buildLevelCard(
                'Intermediate', 'Moderate experience with consistent training'),
            _buildLevelCard(
                'Advanced', 'Very experienced with consistent training       '),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_selectedLevel.isNotEmpty) {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .update({'fitnessLevel': _selectedLevel});

                    Navigator.pushNamed(context, AppRoutes.home);
                  }
                } else {
                  // Show a message to select a level
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a fitness level')),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(String level, String description) {
    return GestureDetector(
      onTap: () => _selectLevel(level),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _selectedLevel == level ? Colors.orange : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                level,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
