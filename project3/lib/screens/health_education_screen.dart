import 'package:flutter/material.dart';
import 'dart:math'; // Import to use Random

class HealthEducationScreen extends StatelessWidget {
  HealthEducationScreen({Key? key}) : super(key: key);

  // Sample data for health education topics
  final List<Map<String, String>> topics = [
    {
      'title': 'Nutrition Basics',
      'description': 'Learn about the essential nutrients for a healthy diet.',
    },
    {
      'title': 'Mental Health Awareness',
      'description': 'Understand the importance of mental health and wellness.',
    },
    {
      'title': 'Exercise and Fitness',
      'description': 'Get tips on how to stay active and fit.',
    },
    {
      'title': 'Preventive Healthcare',
      'description':
          'Find out how to prevent diseases and maintain good health.',
    },
  ];

  // List of colors for the cards
  final List<Color> cardColors = [
    Colors.teal[100]!,
    Colors.green[100]!,
    Colors.blue[100]!,
    Colors.orange[100]!,
    Colors.pink[100]!,
    Colors.yellow[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Education'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return _buildTopicCard(topics[index], index);
          },
        ),
      ),
    );
  }

  // Method to build a card for each health education topic with a random color
  Widget _buildTopicCard(Map<String, String> topic, int index) {
    // Get a random color from the list
    final Random random = Random();
    Color cardColor = cardColors[random.nextInt(cardColors.length)];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: cardColor, // Use the randomly selected color
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic['title']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(topic['description']!),
          ],
        ),
      ),
    );
  }
}
