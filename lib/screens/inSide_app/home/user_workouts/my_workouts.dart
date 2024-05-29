import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MyWorkoutsPage extends StatefulWidget {
  @override
  _MyWorkoutsPageState createState() => _MyWorkoutsPageState();
}

class _MyWorkoutsPageState extends State<MyWorkoutsPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> workouts = [
    {
      'title': 'Pull',
      'description': 'Calisthenics • Weighted • Strength Building',
      'rating': 4.5
    },
    {
      'title': 'Push',
      'description': 'Calisthenics • Weighted • Rep Building',
      'rating': 4.0
    },
    {
      'title': 'Abs',
      'description': 'Calisthenics • Fat Burning',
      'rating': 4.8
    },
  ];
  List<Map<String, dynamic>> filteredWorkouts = [];

  @override
  void initState() {
    super.initState();
    filteredWorkouts = workouts;
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
        return workout['title'].toLowerCase().contains(query) ||
            workout['description'].toLowerCase().contains(query);
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
                itemCount: filteredWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = filteredWorkouts[index];
                  return Card(
                    child: ListTile(
                      title: Text(workout['title']),
                      subtitle: Text(workout['description']),
                      trailing: Text('${workout['rating']} ⭐'),
                      onTap: () {
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
}
