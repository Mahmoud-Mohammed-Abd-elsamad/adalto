import 'package:flutter/material.dart';

class ShopFilterPage extends StatefulWidget {
  @override
  _ShopFilterPageState createState() => _ShopFilterPageState();
}

class _ShopFilterPageState extends State<ShopFilterPage> {
  List<String> categories = [
    'Accessories',
    'Protein & Nutritions',
    'Equipment'
  ];
  Map<String, bool> selectedCategories = {
    'Accessories': false,
    'Protein & Nutritions': false,
    'Equipment': false,
  };

  void resetFilters() {
    setState(() {
      selectedCategories.updateAll((key, value) => false);
    });
  }

  void applyFilters() {
    // Logic to apply filters
    Navigator.pop(context, selectedCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Shop Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: categories.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: selectedCategories[category] ?? false,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategories[category] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: resetFilters,
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: applyFilters,
                  child: Text('Apply Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
