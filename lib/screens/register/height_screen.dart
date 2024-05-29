import 'package:adalato_app/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';


class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  String _selectedHeight = '170';

  void _showHeightPicker(BuildContext context) {
    showMaterialNumberPicker(
      context: context,
      title: 'Select Weight',
      maxNumber: 200,
      minNumber: 30,
      selectedNumber: int.parse(_selectedHeight),
      onChanged: (value) {
        setState(() {
          _selectedHeight = value.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Height',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showHeightPicker(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(20),
              child: Text(
                '$_selectedHeight cm',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .update({'height': _selectedHeight});

                Navigator.pushNamed(context, AppRoutes.weight);
              }
            }, child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
