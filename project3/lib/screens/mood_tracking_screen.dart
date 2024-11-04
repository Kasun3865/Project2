// screens/mood_tracking_screen.dart
import 'package:flutter/material.dart';
import 'package:project3/models/mood_provider.dart';
import '../models/mood.dart';
import 'package:provider/provider.dart';

class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  _MoodTrackingScreenState createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen> {
  String? selectedMood;
  TextEditingController noteController = TextEditingController();

  // Function to get the icon and color based on selected mood
  IconData? _getMoodIcon(String mood) {
    switch (mood) {
      case 'Happy':
        return Icons.sentiment_very_satisfied;
      case 'Sad':
        return Icons.sentiment_dissatisfied;
      case 'Neutral':
        return Icons.sentiment_neutral;
      case 'Angry':
        return Icons.sentiment_very_dissatisfied;
      case 'Excited':
        return Icons.sentiment_satisfied_alt;
      default:
        return null;
    }
  }

  Color? _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return Colors.yellow; // Bright yellow for happiness
      case 'Sad':
        return Colors.blue; // Calming blue for sadness
      case 'Neutral':
        return Colors.grey; // Neutral grey
      case 'Angry':
        return Colors.red; // Intense red for anger
      case 'Excited':
        return Colors.orange; // Vibrant orange for excitement
      default:
        return Colors.black;
    }
  }

  void _saveMood() {
    if (selectedMood != null) {
      final newMood = Mood(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        moodType: selectedMood!,
        note: noteController.text,
        icon: '', // You can set an icon name if needed
      );

      // Add the new mood to the provider or database.
      Provider.of<MoodProvider>(context, listen: false).addMood(newMood);

      // Clear the input fields after saving
      setState(() {
        selectedMood = null;
        noteController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Your Mood')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('How are you feeling today?',
                style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              hint: const Text('Select your mood'),
              value: selectedMood,
              items: ['Happy', 'Sad', 'Neutral', 'Angry', 'Excited']
                  .map((mood) => DropdownMenuItem(
                        value: mood,
                        child: Row(
                          children: [
                            Icon(
                              _getMoodIcon(mood),
                              color: _getMoodColor(
                                  mood), // Set icon color based on mood
                            ),
                            const SizedBox(width: 8),
                            Text(mood),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMood = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (selectedMood != null) // Display selected mood icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getMoodIcon(selectedMood!),
                    color: _getMoodColor(selectedMood!),
                    size: 40, // Icon size
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedMood!,
                    style: TextStyle(
                      fontSize: 24,
                      color: _getMoodColor(selectedMood!),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            TextField(
              controller: noteController,
              decoration:
                  const InputDecoration(labelText: 'Add a note (optional)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMood,
              child: const Text('Save Mood'),
            ),
          ],
        ),
      ),
    );
  }
}
