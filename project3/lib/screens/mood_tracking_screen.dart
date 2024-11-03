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

  void _saveMood() {
    if (selectedMood != null) {
      final newMood = Mood(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        moodType: selectedMood!,
        note: noteController.text,
        icon: '',
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
                        child: Text(mood),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMood = value;
                });
              },
            ),
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
