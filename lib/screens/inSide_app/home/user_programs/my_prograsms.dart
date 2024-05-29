import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MyProgramsPage extends StatelessWidget {
  final List<Map<String, dynamic>> programs = [
    {
      'title': '100 Push Ups For 7 Days Challenge',
      'description': 'A week-long calisthenics challenge',
      'duration': '1 Week',
      'difficultyLevel': 'Beginner',
      'rating': 4.5,
      'tags': ['Calisthenics', 'Strength']
    },
    {
      'title': 'Complete Human Flag Program',
      'description': '5 weeks calisthenics program',
      'duration': '5 Weeks',
      'difficultyLevel': 'Advanced',
      'rating': 4.8,
      'tags': ['Calisthenics', 'Strength']
    },
    {
      'title': 'Complete Back Lever Program For All Levels',
      'description': '4 weeks calisthenics program',
      'duration': '4 Weeks',
      'difficultyLevel': 'Intermediate',
      'rating': 4.7,
      'tags': ['Calisthenics', 'Strength']
    },
    // Add more program details as needed
  ];

  void _onProgramTap(BuildContext context, Map<String, dynamic> program) {
    Navigator.pushNamed(context, AppRoutes.program);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Future functionality to filter programs
              Navigator.pushNamed(context, AppRoutes.programsFilter);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return GestureDetector(
            onTap: () => _onProgramTap(context, program),
            child: Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      // Uncomment the line below to add image from assets
                      // image: DecorationImage(image: AssetImage('path/to/your/image'), fit: BoxFit.cover)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          program['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Duration: ${program['duration']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Difficulty Level: ${program['difficultyLevel']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Rating: ${program['rating']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < program['rating']
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow[700],
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: program['tags'].map<Widget>((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor: Colors.red[100],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
