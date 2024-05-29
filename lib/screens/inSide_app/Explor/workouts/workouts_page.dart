import 'dart:developer';

import 'package:adalato_app/utils/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../models/workout_model.dart';

class WorkoutsPage extends StatefulWidget {
  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  TextEditingController _searchController = TextEditingController();
  final CollectionReference _workoutsCollectionRef =
  FirebaseFirestore.instance.collection('workouts');
  List<WorkoutModel> workouts = [];



  // [
  //   {
  //     'title': 'Pull',
  //     'description': 'Calisthenics • Weighted • Strength Building',
  //     'rating': 4.5
  //   },
  //   {
  //     'title': 'Push',
  //     'description': 'Calisthenics • Weighted • Rep Building',
  //     'rating': 4.0
  //   },
  //   {
  //     'title': 'Abs',
  //     'description': 'Calisthenics • Fat Burning',
  //     'rating': 4.8
  //   },
  // ];
   List<WorkoutModel> filteredWorkouts = [];

  @override
  void initState() {
    super.initState();
   filteredWorkouts = workouts;
    fetchWorkoutList();
    _searchController.addListener(_filterWorkouts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterWorkouts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredWorkouts = workouts.where((workout) {
        return workout.title.toLowerCase().contains(query) ||
            workout.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts Library'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.workoutsFilter);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      title: Text(workouts[index].title),
                      subtitle: Text(workouts[index].description),
                      trailing: Text('${workouts[index].rating} ⭐'),
                      onTap: () {
                        // Handle tap
                        Navigator.pushNamed(context, AppRoutes.workout);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> fetchWorkoutList() async {
    log(
        "fetchTitles >>>>>>>>>>>>>fetchWorkoutTitles>>>>>>>befor try>>>>>>>>>>>>>>>>>>>>>> ${workouts
            .length}");

    try {
      QuerySnapshot querySnapshot = await _workoutsCollectionRef.get();

      setState(() {
        workouts = querySnapshot.docs
            .map((doc) => WorkoutModel.fromDocument(doc))
            .toList();
        log(
            "fetchTitles >>>>>>>>>>>>fetchWorkoutTitles>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${workouts
                .length}");
      });
    } catch (e) {
      log("fetchTitles >>>>>>>>>>>>>>>fetchWorkoutTitles>>>>>>>>>>>>>>>>> catch error ${e
          .toString()}");
    }
  }

}
