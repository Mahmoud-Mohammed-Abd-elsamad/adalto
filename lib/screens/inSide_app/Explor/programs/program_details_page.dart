import 'package:adalato_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProgramDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                color: Colors.grey, // This will be the image from assets
                // Use the following line to load image from assets:
                // child: Image.asset('assets/program_image.jpg', fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  'Complete Human Flag Program',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Add to favorites functionality
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star_rate),
                  color: Colors.deepOrange,
                  onPressed: () {
                    showRatingDialog(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListItem(context, 'Requirements'),
                _buildListItem(context, 'Week 1'),
                _buildListItem(context, 'Week 2'),
                _buildListItem(context, 'Week 3'),
                _buildListItem(context, 'Week 4'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.workout);
        },
      ),
    );
  }

  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rate the Program'),
          content: RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          actions: [
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
