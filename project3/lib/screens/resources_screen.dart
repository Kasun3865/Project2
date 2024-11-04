import 'package:flutter/material.dart';

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Mental Health Resources'),
              subtitle: const Text(
                  'Find various resources to help you with mental health.'),
              onTap: () {
                // Navigate to more information or external links
              },
            ),
            ListTile(
              title: const Text('Self-Care Tips'),
              subtitle: const Text(
                  'Tips for taking care of your mental and emotional health.'),
              onTap: () {
                // Navigate to more information or external links
              },
            ),
            // Add more resources as needed
          ],
        ),
      ),
    );
  }
}
