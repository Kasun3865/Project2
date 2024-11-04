import 'package:flutter/material.dart';
import '../models/mood.dart'; // Ensure you import the Mood model.

class MoodChart extends StatelessWidget {
  final List<Mood> moods;

  const MoodChart({Key? key, required this.moods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Count the occurrences of each mood type
    Map<String, int> moodCounts = {};

    for (var mood in moods) {
      moodCounts[mood.moodType] = (moodCounts[mood.moodType] ?? 0) + 1;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
        children: moodCounts.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 2.0), // Add some vertical spacing
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align items to the start
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: const TextStyle(
                        fontSize:
                            16), // Slightly larger font size for mood names
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: (entry.value * 20).toDouble(), // Width based on count
                  height: 10,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(entry.value.toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
