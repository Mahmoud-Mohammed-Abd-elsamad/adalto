import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class WorkoutDetailsPage extends StatefulWidget {
  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  bool isFavorite = false;
  int rating = 0;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void setRating(int newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String workoutTitle = 'Complete Human Flag Program';
    final String workoutDescription =
        'This program will help you achieve the Human Flag with a series of progressive exercises.';
    final String difficultyLevel = 'Intermediate';
    final String duration = '45 minutes';

    final List<Map<String, String>> exercises = [
      {
        'title': 'Hanging Tuck L-Sit Hold',
        'image':
            'assets/hanging_tuck_l_sit_hold.jpg', // Replace with network image URL
        'details': '15 seconds • rest 60 seconds'
      },
      {
        'title': 'Pull Ups',
        'image': 'assets/pull_ups.jpg', // Replace with network image URL
        'details': '10 reps • rest 60 seconds'
      },
      {
        'title': 'Push Ups',
        'image': 'assets/push_ups.jpg', // Replace with network image URL
        'details': '10 reps • rest 60 seconds'
      },
      {
        'title': 'Straight Bar Dips',
        'image':
            'assets/straight_bar_dips.jpg', // Replace with network image URL
        'details': '10 reps • rest 60 seconds'
      },
      {
        'title': 'Plank Side Hold',
        'image': 'assets/plank_side_hold.jpg', // Replace with network image URL
        'details': '30 seconds each • rest 60 seconds'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share functionality here
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            color: Colors.grey, // Replace with Image.network('imageUrl')
            child: Center(
              child: Text(
                'Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workoutTitle,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '$duration • $difficultyLevel',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  workoutDescription,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: toggleFavorite,
                    ),
                    IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Rate this workout'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < rating
                                          ? Icons.star
                                          : Icons.star_border,
                                    ),
                                    onPressed: () {
                                      setRating(index + 1);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          ...exercises.map((exercise) {
            return GestureDetector(
              onTap: () {
                // Handle the tap event here
                Navigator.pushNamed(context, AppRoutes.exercise);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Clicked on ${exercise['title']}')),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  leading: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    // Replace with Image.network(exercise['image']!)
                    child: Center(
                      child: Text(
                        'Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  title: Text(exercise['title']!),
                  subtitle: Text(exercise['details']!),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WorkoutDetailsPage(),
  ));
}
