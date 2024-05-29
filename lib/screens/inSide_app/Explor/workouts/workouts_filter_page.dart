import 'package:flutter/material.dart';

class WorkoutsFilterPage extends StatefulWidget {
  @override
  _WorkoutsFilterPageState createState() => _WorkoutsFilterPageState();
}

class _WorkoutsFilterPageState extends State<WorkoutsFilterPage> {
  Set<String> selectedLevels = {};
  Set<String> selectedCategories = {};
  Set<String> selectedWorkoutStyles = {};
  Set<String> selectedMuscleGroups = {};

  void _resetFilters() {
    setState(() {
      selectedLevels.clear();
      selectedCategories.clear();
      selectedWorkoutStyles.clear();
      selectedMuscleGroups.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('filter workouts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFilterSection(
              'Level',
              ['Beginner', 'Intermediate', 'Advanced'],
              selectedLevels,
            ),
            _buildFilterSection(
              'Category',
              ['Calisthenics', 'Weighted', 'Weighted calisthenics'],
              selectedCategories,
            ),
            _buildFilterSection(
              'Workout style',
              ['Fat burning', 'Strength building', 'Rep building', 'Tabata'],
              selectedWorkoutStyles,
            ),
            _buildFilterSection(
              'Muscle groups',
              [
                'Back',
                'Biceps',
                'Chest',
                'Legs',
                'Shoulders',
                'Triceps',
                'Abs'
              ],
              selectedMuscleGroups,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Apply filters logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('apply filters'),
            ),
            TextButton(
              onPressed: _resetFilters,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text('Reset', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(
      String title, List<String> options, Set<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedOptions.add(option);
                  } else {
                    selectedOptions.remove(option);
                  }
                });
              },
              selectedColor: Colors.black,
              backgroundColor: Colors.grey[200],
              labelStyle:
                  TextStyle(color: isSelected ? Colors.white : Colors.black),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
