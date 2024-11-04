import 'package:flutter/material.dart';
import 'game_screen.dart'; // Import the GameScreen

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
            Card(
              color: Colors.green[50],
              child: ListTile(
                leading: Icon(Icons.videogame_asset,
                    color: Colors.green[700]), // Game icon
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
          ],
        ),
      ),
    );
  }
}
