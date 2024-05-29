import 'package:flutter/material.dart';

class MyExercisePage extends StatefulWidget {
  @override
  _MyExercisePageState createState() => _MyExercisePageState();
}

class _MyExercisePageState extends State<MyExercisePage> {
  int maxReps = 0;
  double maxWeight = 0.0;

  void incrementReps() {
    setState(() {
      maxReps++;
    });
  }

  void decrementReps() {
    if (maxReps > 0) {
      setState(() {
        maxReps--;
      });
    }
  }

  void incrementWeight() {
    setState(() {
      maxWeight += 2.5;
    });
  }

  void decrementWeight() {
    if (maxWeight > 0) {
      setState(() {
        maxWeight -= 2.5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Details'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Exercise Image Placeholder
            Container(
              height: 200,
              color: Colors.grey,
              child: const Center(child: Text('Exercise Video Placeholder')),
            ),
            const SizedBox(height: 20),
            // Max Reps and Max Weight Counters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Max Reps Counter
                  Column(
                    children: [
                      const Text('Max Reps', style: TextStyle(fontSize: 18)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: decrementReps,
                          ),
                          Text('$maxReps', style: const TextStyle(fontSize: 18)),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: incrementReps,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Max Weight Counter
                  Column(
                    children: [
                      const Text('Max Weight', style: TextStyle(fontSize: 18)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: decrementWeight,
                          ),
                          Text('${maxWeight.toStringAsFixed(1)} kg',
                              style: const TextStyle(fontSize: 18)),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: incrementWeight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Exercise Title and Details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tuck Planche to Straddle Planche',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description of the exercise goes here. It includes steps, form tips, and other details.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('Muscle Groups: Shoulders',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Level: Advanced', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Equipment: Parallettes',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Repetitions: 10', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            // Favorite and Rate Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle favorite logic here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () {
                    // Handle rating logic here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
