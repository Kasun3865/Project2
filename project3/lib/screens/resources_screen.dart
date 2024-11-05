import 'package:flutter/material.dart';
import 'game_screen.dart'; // Import the GameScreen
import 'hospital_map_screen.dart'; // Import the HospitalMapScreen
import 'eye_test_screen.dart'; // Import the EyeTestScreen
import 'pharmacy_map_screen.dart'; // Import the PharmacyMapScreen
import 'health_education_screen.dart'; // Import the HealthEducationScreen
import 'health_events_screen.dart'; // Import the HealthEventsScreen
import 'health_tracker_screen.dart'; // Import the HealthTrackerScreen
import 'symptom_checker_screen.dart'; // Import the SymptomCheckerScreen
import 'bmi_calculator_screen.dart'; // Import the BMICalculatorScreen
import 'health_news_screen.dart'; // Import the HealthNewsScreen

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
            const SizedBox(height: 20),
            // Health Events card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.event, color: Colors.green[700]),
                title: const Text('Local Health Events'),
                subtitle: const Text('Stay updated on upcoming health events.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthEventsScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Health Tracker card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.track_changes, color: Colors.green[700]),
                title: const Text('Health Tracker'),
                subtitle: const Text('Track your health metrics over time.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HealthTrackerScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Symptom Checker card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.local_hospital, color: Colors.green[700]),
                title: const Text('Symptom Checker'),
                subtitle: const Text('Check your symptoms and get advice.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SymptomCheckerScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // BMI Calculator card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.calculate, color: Colors.green[700]),
                title: const Text('BMI Calculator'),
                subtitle: const Text('Calculate your Body Mass Index.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BMICalculatorScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Health News card
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.article, color: Colors.green[700]),
                title: const Text('Health News'),
                subtitle:
                    const Text('Stay updated with the latest health news.'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HealthNewsScreen()),
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
