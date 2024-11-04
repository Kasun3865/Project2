// models/mood.dart
class Mood {
  final String id;
  final DateTime date;
  final String moodType; // Example: "Happy", "Sad", "Neutral", etc.
  final String
      note; // Optional: A note or description of why the user felt this way.
  final String icon; // New field to store the mood icon

  Mood({
    required this.id,
    required this.date,
    required this.moodType,
    this.note = '',
    required this.icon,
  });

  // Convert a Mood object into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'moodType': moodType,
      'note': note,
      'icon': icon, // Add icon to the map
    };
  }

  // Convert a Map into a Mood object
  factory Mood.fromMap(Map<String, dynamic> map) {
    return Mood(
      id: map['id'],
      date: DateTime.parse(map['date']),
      moodType: map['moodType'],
      note: map['note'],
      icon: map['icon'], // Retrieve icon from the map
    );
  }
}
