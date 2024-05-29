import 'package:flutter/material.dart';

class ProgramsFilterPage extends StatefulWidget {
  @override
  _ProgramsFilterPageState createState() => _ProgramsFilterPageState();
}

class _ProgramsFilterPageState extends State<ProgramsFilterPage> {
  List<String> levels = ['Beginner', 'Intermediate', 'Advanced'];
  List<String> categories = [
    'Calisthenics',
    'Weighted',
    'Weighted calisthenics'
  ];

  String selectedLevel = '';
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Programs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Level',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: levels
                  .map((level) => ChoiceChip(
                        label: Text(level),
                        selected: selectedLevel == level,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedLevel = (selected ? level : null)!;
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text('Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: categories
                  .map((category) => ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = (selected ? category : null)!;
                          });
                        },
                      ))
                  .toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Apply filters logic here
              },
              child: Text('Apply Filters'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedLevel = '';
                    selectedCategory = '';
                  });
                },
                child: Text('Reset'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
