import 'package:flutter/material.dart';

class HospitalMapScreen extends StatelessWidget {
  HospitalMapScreen({super.key});

  // Sample list of hospitals with additional details
  final List<Map<String, String>> hospitals = [
    {
      'name': 'Colombo National Hospital',
      'phone': '011 123 4567',
      'address': '29, Kynsey Road, Colombo 08',
      'services': 'General, Emergency, Maternity',
      'rating': '4.5',
    },
    {
      'name': 'Sri Jayawardenepura General Hospital',
      'phone': '011 234 5678',
      'address': '1, Pannipitiya Road, Kotte',
      'services': 'General, Surgery, Cardiology',
      'rating': '4.0',
    },
    {
      'name': 'Lady Ridgeway Hospital',
      'phone': '011 123 9876',
      'address': 'No 24, Cotta Road, Colombo 08',
      'services': 'Pediatrics, Neonatology, Emergency',
      'rating': '4.8',
    },
    {
      'name': 'Kandy General Hospital',
      'phone': '011 223 4567',
      'address': '11, Hospital Road, Kandy',
      'services': 'General, Trauma, Rehabilitation',
      'rating': '4.3',
    },
    {
      'name': 'Teaching Hospital Karapitiya',
      'phone': '011 234 5678',
      'address': 'Karapitiya, Galle',
      'services': 'General, Oncology, Radiology',
      'rating': '4.2',
    },
  ];

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
        title: const Text('Nearby Hospitals'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'List of Hospitals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  return _buildHospitalCard(hospitals[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalCard(Map<String, String> hospital, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      color: cardColors[index % cardColors.length], // Cycle through colors
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hospital['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${hospital['phone']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Address: ${hospital['address']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Services: ${hospital['services']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                ..._buildStarRating(hospital['rating']!),
                const SizedBox(width: 8), // Spacing between stars and number
                Text(
                  hospital['rating']!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStarRating(String rating) {
    double ratingValue = double.parse(rating);
    int fullStars = ratingValue.floor(); // Number of full stars
    bool hasHalfStar = ratingValue - fullStars >= 0.5; // Check for half star
    List<Widget> stars = [];

    // Add full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber));
    }

    // Add half star if applicable
    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber));
    }

    // Add empty stars to make a total of 5 stars
    for (int i = stars.length; i < 5; i++) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber));
    }

    return stars;
  }
}
