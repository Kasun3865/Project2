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
      // Assign a specific icon color for each mood type
      String iconColor;
      switch (selectedMood) {
        case 'Happy':
          iconColor = 'yellow';
          break;
        case 'Sad':
          iconColor = 'blue';
          break;
        case 'Neutral':
          iconColor = 'grey';
          break;
        case 'Angry':
          iconColor = 'red';
          break;
        case 'Excited':
          iconColor = 'orange';
          break;
        default:
          iconColor = 'grey';
      }

      final newMood = Mood(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        moodType: selectedMood!,
        note: noteController.text,
        icon: iconColor, // Store the icon color
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
    final moods = Provider.of<MoodProvider>(context).moods;

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
            const SizedBox(height: 20),
            const Divider(),
            const Text('Mood History:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  final mood = moods[moods.length - 1 - index];
                  return ListTile(
                    leading: _getColoredIcon(mood.icon),
                    title: Text(mood.moodType),
                    subtitle: Text('${mood.date.toLocal()} \n${mood.note}'),
                    isThreeLine: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Returns an icon with color based on the mood type
  Icon _getColoredIcon(String iconColor) {
    Color color;
    switch (iconColor) {
      case 'yellow':
        color = Colors.yellow;
        break;
      case 'blue':
        color = Colors.blue;
        break;
      case 'grey':
        color = Colors.grey;
        break;
      case 'red':
        color = Colors.red;
        break;
      case 'orange':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
    }

    return Icon(
      Icons.circle, // Use a circle icon as the colored indicator
      color: color,
      size: 40,
    );
  }
}
