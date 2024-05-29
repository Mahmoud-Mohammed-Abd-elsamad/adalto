import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MyExercisesPage extends StatefulWidget {
  @override
  _MyExercisesPageState createState() => _MyExercisesPageState();
}

class _MyExercisesPageState extends State<MyExercisesPage> {
  final List<Map<String, String>> exercises = [
    {
      'title': 'Tuck Planche to Straddle Planche',
      'duration': '15 mins',
      'muscleGroup': 'Shoulders',
      // 'imageUrl': 'assets/tuck_planche.jpg' // Placeholder image path
    },
    {
      'title': 'Wall Plank Hold - Weighted Vest',
      'duration': '10 mins',
      'muscleGroup': 'Abs, Shoulders',
      // 'imageUrl': 'assets/wall_plank_hold.jpg' // Placeholder image path
    },
    {
      'title': 'L-Sit Flutters',
      'duration': '10 mins',
      'muscleGroup': 'Abs',
      // 'imageUrl': 'assets/l_sit_flutters.jpg' // Placeholder image path
    },
    {
      'title': 'Hammer Curls - Dumbbell',
      'duration': '8 mins',
      'muscleGroup': 'Biceps',
      // 'imageUrl': 'assets/hammer_curls.jpg' // Placeholder image path
    },
    {
      'title': 'Muscle Up',
      'duration': '12 mins',
      'muscleGroup': 'Back, Biceps, Shoulders, Triceps',
      // 'imageUrl': 'assets/muscle_up.jpg' // Placeholder image path
    },
    {
      'title': 'One Arm Chin Up Switching Arm',
      'duration': '10 mins',
      'muscleGroup': 'Back, Biceps',
      // 'imageUrl': 'assets/one_arm_chin_up.jpg' // Placeholder image path
    },
    {
      'title': 'Cross Lunges',
      'duration': '15 mins',
      'muscleGroup': 'Legs',
      // 'imageUrl': 'assets/cross_lunges.jpg' // Placeholder image path
    },
  ];

  late List<Map<String, String>> filteredExercises;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredExercises = exercises;
    searchController.addListener(_filterExercises);
  }

  void _filterExercises() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredExercises = exercises.where((exercise) {
        final titleLower = exercise['title']!.toLowerCase();
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
              itemCount: filteredExercises.length,
              itemBuilder: (context, index) {
                final exercise = filteredExercises[index];
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
                    title: Text(exercise['title']!),
                    subtitle: Text(
                        '${exercise['duration']} • ${exercise['muscleGroup']}'),
                    onTap: () {
                      // Handle exercise card tap
                      Navigator.pushNamed(context, AppRoutes.myExercise);
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
}
