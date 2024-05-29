import 'package:flutter/material.dart';

class ExercisesFilterPage extends StatefulWidget {
  @override
  _ExercisesFilterPageState createState() => _ExercisesFilterPageState();
}

class _ExercisesFilterPageState extends State<ExercisesFilterPage> {
  final Set<String> _selectedLevels = {};
  final Set<String> _selectedMuscleGroups = {};
  final Set<String> _selectedEquipment = {};

  final List<String> _levels = ['Beginner', 'Intermediate', 'Advanced'];
  final List<String> _muscleGroups = [
    'Back',
    'Biceps',
    'Chest',
    'Legs',
    'Shoulders',
    'Triceps',
    'Abs'
  ];
  final List<String> _equipment = [
    'No equipment',
    'Barbell',
    'Dip bar',
    'Dumbbell',
    'Rings',
    'Parallettes',
    'Pull up bar',
    'Weight Vest',
    'Other'
  ];

  void _toggleSelection(Set<String> selectionSet, String item) {
    setState(() {
      if (selectionSet.contains(item)) {
        selectionSet.remove(item);
      } else {
        selectionSet.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Exercises'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterSection(
              title: 'Level',
              options: _levels,
              selectedOptions: _selectedLevels,
            ),
            _buildFilterSection(
              title: 'Muscle groups',
              options: _muscleGroups,
              selectedOptions: _selectedMuscleGroups,
            ),
            _buildFilterSection(
              title: 'Equipment',
              options: _equipment,
              selectedOptions: _selectedEquipment,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Apply filter logic
              },
              child: Text('Apply Filters'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedLevels.clear();
                  _selectedMuscleGroups.clear();
                  _selectedEquipment.clear();
                });
              },
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<String> options,
    required Set<String> selectedOptions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return GestureDetector(
              onTap: () => _toggleSelection(selectedOptions, option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
