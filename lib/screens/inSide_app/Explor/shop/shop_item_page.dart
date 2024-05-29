import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShopItemPage(),
    );
  }
}

class ShopItemPage extends StatelessWidget {
  final String name = 'Test Product';
  final String description = 'This is a test description of the product.';
  final String price = '\$20';
  final String category = 'Test Category';
  final String imageUrl = 'https://example.com/image.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey,
                // Image.network(imageUrl) would be here
                child: Center(child: Text('Product Image')),
              ),
              SizedBox(height: 16.0),
              Text(
                name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Category: $category',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8.0),
              Text(
                'Price: $price',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
