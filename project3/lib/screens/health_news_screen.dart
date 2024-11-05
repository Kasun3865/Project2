import 'package:flutter/material.dart';
import 'dart:math'; // Import for random color generation

class HealthNewsScreen extends StatelessWidget {
  // List of news articles
  final List<Map<String, String>> newsArticles = [
    {
      'title': 'New Breakthrough in Cancer Research',
      'description': 'Researchers have developed a new treatment for cancer...',
    },
    {
      'title': 'The Importance of Regular Exercise',
      'description':
          'Regular physical activity can help prevent chronic diseases...',
    },
    {
      'title': 'Understanding Mental Health',
      'description':
          'Mental health awareness is crucial for overall well-being...',
    },
    // Add more articles as needed
  ];

  // List of colors to use for the cards
  final List<Color> cardColors = [
    Colors.red.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health News'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          final article = newsArticles[index];

          // Select a random color from the list of card colors
          final randomColor = cardColors[Random().nextInt(cardColors.length)];

          return Card(
            color: randomColor, // Set the card color
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(article['title']!),
              subtitle: Text(article['description']!),
              onTap: () {
                // Add functionality to view full article or details if needed
              },
            ),
          );
        },
      ),
    );
  }
}
