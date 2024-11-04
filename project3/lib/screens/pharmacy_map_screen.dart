import 'package:flutter/material.dart';

class PharmacyMapScreen extends StatelessWidget {
  PharmacyMapScreen({super.key});

  // Sample data for pharmacies, including address and ratings
  final List<Map<String, dynamic>> pharmacies = [
    {
      'name': 'City Pharmacy',
      'phone': '011-2345678',
      'hours': '8 AM - 8 PM',
      'services': 'Prescription filling, over-the-counter medications',
      'address': '123 Main St, City Center',
      'rating': 4, // Rating out of 5
    },
    {
      'name': 'Health Mart',
      'phone': '011-8765432',
      'hours': '9 AM - 9 PM',
      'services': 'Prescription medications, health consultations',
      'address': '456 Health Ave, Downtown',
      'rating': 5,
    },
    {
      'name': 'Wellness Pharmacy',
      'phone': '011-1234567',
      'hours': '7 AM - 10 PM',
      'services': 'Vaccinations, health screenings',
      'address': '789 Wellness Blvd, Uptown',
      'rating': 3,
    },
    {
      'name': 'Community Drug Store',
      'phone': '011-7654321',
      'hours': '8 AM - 10 PM',
      'services': 'Home delivery, health advice',
      'address': '101 Community Rd, Suburb',
      'rating': 4,
    },
  ];

  // List of colors to use for pharmacy cards
  final List<Color> cardColors = [
    Colors.teal[100]!,
    Colors.blue[100]!,
    Colors.amber[100]!,
    Colors.green[100]!,
    Colors.pink[100]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Pharmacies'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: pharmacies.length,
          itemBuilder: (context, index) {
            return _buildPharmacyCard(pharmacies[index], index);
          },
        ),
      ),
    );
  }

  // Method to build a card for each pharmacy
  Widget _buildPharmacyCard(Map<String, dynamic> pharmacy, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: cardColors[index % cardColors.length], // Cycle through colors
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pharmacy['name']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Phone: ${pharmacy['phone']}'),
            Text('Hours: ${pharmacy['hours']}'),
            Text('Address: ${pharmacy['address']}'),
            Text('Services: ${pharmacy['services']}'),
            const SizedBox(height: 8),
            Row(
              children: [
                for (int i = 0; i < pharmacy['rating']; i++)
                  const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text('(${pharmacy['rating']})'), // Displaying the rating
              ],
            ),
          ],
        ),
      ),
    );
  }
}
