import 'package:flutter/material.dart';
import 'game_screen.dart'; // Import the GameScreen
import 'hospital_map_screen.dart'; // Import the HospitalMapScreen
import 'eye_test_screen.dart'; // Import the EyeTestScreen
import 'pharmacy_map_screen.dart'; // Import the PharmacyMapScreen
import 'health_education_screen.dart'; // Import the HealthEducationScreen

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
            const SizedBox(height: 20),
            // Game card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.videogame_asset, color: Colors.green[700]),
                title: const Text('Games'),
                subtitle:
                    const Text('Take a break and play some engaging games.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Hospital card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.local_hospital, color: Colors.green[700]),
                title: const Text('Nearby Hospitals'),
                subtitle: const Text(
                    'Find nearby hospitals and healthcare facilities.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HospitalMapScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Pharmacy card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.local_pharmacy, color: Colors.green[700]),
                title: const Text('Nearby Pharmacies'),
                subtitle:
                    const Text('Find nearby pharmacies and their services.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PharmacyMapScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Eye Test card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.visibility, color: Colors.green[700]),
                title: const Text('Eye Test'),
                subtitle: const Text('Check your vision with our eye test.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EyeTestScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Health Education card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.school, color: Colors.green[700]),
                title: const Text('Health Education'),
                subtitle: const Text('Learn about health topics and tips.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthEducationScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
