// health_events_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'health_event.dart'; // Import the HealthEvent class

class HealthEventsScreen extends StatelessWidget {
  HealthEventsScreen({Key? key}) : super(key: key);

  // Sample data for health events
  final List<HealthEvent> events = [
    HealthEvent(
      title: 'Free Health Check-up Camp',
      date: DateTime(2024, 11, 10),
      time: '9 AM - 1 PM',
      location: 'Community Center, 123 Health St.',
      description: 'Join us for a free health check-up and consultation.',
    ),
    HealthEvent(
      title: 'Mental Health Awareness Workshop',
      date: DateTime(2024, 11, 15),
      time: '2 PM - 4 PM',
      location: 'Health Institute, 456 Wellness Ave.',
      description: 'Learn about mental health and coping strategies.',
      url: 'https://example.com/workshop', // Optional URL
    ),
    // Add more events as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Health Events'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return _buildEventCard(events[index]);
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(HealthEvent event) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.teal[50],
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
                'Date: ${event.date.toLocal().toString().split(' ')[0]}'), // Format date
            Text('Time: ${event.time}'),
            Text('Location: ${event.location}'),
            const SizedBox(height: 8),
            Text(event.description),
          ],
        ),
      ),
    );
  }
}
