import 'dart:developer';

import 'package:adalato_app/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../models/excersise_model.dart';


class ExercisesPage extends StatefulWidget {
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final CollectionReference _exercisesCollectionRef =
  FirebaseFirestore.instance.collection('exercises');
   List<ExerciseModel> exercises = [];
  //
  // [
  //   {
  //     'title': 'Tuck Planche to Straddle Planche',
  //     'duration': '15 mins',
  //     'muscleGroup': 'Shoulders',
  //     // 'imageUrl': 'assets/tuck_planche.jpg' // Placeholder image path
  //   },
  //   {
  //     'title': 'Wall Plank Hold - Weighted Vest',
  //     'duration': '10 mins',
  //     'muscleGroup': 'Abs, Shoulders',
  //     // 'imageUrl': 'assets/wall_plank_hold.jpg' // Placeholder image path
  //   },
  //   {
  //     'title': 'L-Sit Flutters',
  //     'duration': '10 mins',
  //     'muscleGroup': 'Abs',
  //     // 'imageUrl': 'assets/l_sit_flutters.jpg' // Placeholder image path
  //   },
  //   {
  //     'title': 'Hammer Curls - Dumbbell',
  //     'duration': '8 mins',
  //     'muscleGroup': 'Biceps',
  //     // 'imageUrl': 'assets/hammer_curls.jpg' // Placeholder image path
  //   },
  //   {
  //     'title': 'Muscle Up',
  //     'duration': '12 mins',
  //     'muscleGroup': 'Back, Biceps, Shoulders, Triceps',
  //     // 'imageUrl': 'assets/muscle_up.jpg' // Placeholder image path
  //   },
  //   {
  //     'title': 'One Arm Chin Up Switching Arm',
  //     'duration': '10 mins',
  //     'muscleGroup': 'Back, Biceps',
  //   },
  //   {
  //     'title': 'Cross Lunges',
  //     'duration': '15 mins',
  //     'muscleGroup': 'Legs',
  //     // 'imageUrl': 'assets/cross_lunges.jpg' // Placeholder image path
  //   },
  // ];

  late List<ExerciseModel> filteredExercises;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredExercises = exercises;
    fetchExercisesList();// 'imageUrl': 'assets/one_arm_chin_up.jpg' // Placeholder image path

    searchController.addListener(_filterExercises);
  }

  void _filterExercises() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredExercises = exercises.where((exercise) {
        final titleLower = exercise.exerciseTitle.toLowerCase();
        return titleLower.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Handle filter action
              Navigator.pushNamed(context, AppRoutes.exercisesFilter);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search exercises',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:exercises.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey, // Placeholder for exercise image
                      child: Center(
                        child: Text(
                          'Image', // Placeholder text
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    title: Text(exercises[index].exerciseTitle),
                    subtitle: Text(
                        '${exercises[index].exerciseDescription} • ${exercises[index].muscleGroup}'),
                    onTap: () {
                      // Handle exercise card tap
                      Navigator.pushNamed(context, AppRoutes.exercise);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> fetchExercisesList() async {
    log(
        "fetchTitles >>>>>>>>>>>>>>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${exercises
            .length}");

    try {
      QuerySnapshot querySnapshot = await _exercisesCollectionRef.get();

      setState(() {
        exercises = querySnapshot.docs
            .map((doc) => ExerciseModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${exercises
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }

}
