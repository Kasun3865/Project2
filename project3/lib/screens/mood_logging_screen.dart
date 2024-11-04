import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/screens/mood_chart.dart';
import 'package:project3/screens/notifications_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_account_screen.dart';
import 'feedback_screen.dart';
import 'emergency_contact_screen.dart';
import 'resources_screen.dart'; // Import the ResourcesScreen
import '../models/mood.dart';
import '../models/mood_provider.dart';
import 'package:provider/provider.dart';
import 'chat_screen.dart';
import 'journal_screen.dart'; // Import the JournalScreen
// Import the MoodChart

class MoodLoggingScreen extends StatefulWidget {
  const MoodLoggingScreen({super.key});

  @override
  _MoodLoggingScreenState createState() => _MoodLoggingScreenState();
}

class _MoodLoggingScreenState extends State<MoodLoggingScreen> {
  int _notificationCount = 0;
  String? selectedMoodIcon;
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchNotificationCount();
  }

  Future<void> _fetchNotificationCount() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('notifications')
          .where('read', isEqualTo: false)
          .get();

      setState(() {
        _notificationCount = snapshot.docs.length;
      });
    }
  }

  void _saveMood() {
    if (selectedMoodIcon != null) {
      final newMood = Mood(
        id: DateTime.now().toString(),
        date: DateTime.now(),
        moodType: _getMoodName(selectedMoodIcon!),
        note: noteController.text,
        icon: selectedMoodIcon!,
      );

      Provider.of<MoodProvider>(context, listen: false).addMood(newMood);

      setState(() {
        selectedMoodIcon = null;
        noteController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood saved successfully!')),
      );
    }
  }

  void _navigateToResources() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResourcesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moods = Provider.of<MoodProvider>(context).moods;

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.green[700]),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAccountScreen()),
            );
          },
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.green[700]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationsScreen()),
                  );
                },
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mood Insights:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              MoodChart(moods: moods), // Integrate MoodChart here
              const SizedBox(height: 20), // Add space after the chart
              const Text('Select your mood:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMoodIcon('happy', Icons.sentiment_very_satisfied,
                      'Happy', const Color.fromARGB(255, 6, 202, 160)),
                  _buildMoodIcon('neutral', Icons.sentiment_satisfied,
                      'Neutral', Colors.blue),
                  _buildMoodIcon(
                      'sad', Icons.sentiment_dissatisfied, 'Sad', Colors.grey),
                  _buildMoodIcon('angry', Icons.sentiment_very_dissatisfied,
                      'Angry', Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Add a note (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMood,
                child: const Text('Save Mood'),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const Text('Mood History:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  final mood = moods[moods.length - 1 - index];
                  return ListTile(
                    leading: Icon(_getMoodIcon(mood.icon)),
                    title: Text(mood.moodType),
                    subtitle: Text('${mood.date.toLocal()} \n${mood.note}'),
                    isThreeLine: true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.green[300],
        onTap: (int index) {
          if (index == 0) {
            // Today - MoodLoggingScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MoodLoggingScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JournalScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmergencyContactScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedbackScreen()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ResourcesScreen()), // Navigate to Resources
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Emergency Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            // New Resources item
            icon: Icon(Icons.menu_book),
            label: 'Resources',
          ),
        ],
      ),
    );
  }

  Widget _buildMoodIcon(
      String moodName, IconData iconData, String label, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMoodIcon = moodName;
        });
      },
      child: Column(
        children: [
          Icon(
            iconData,
            size: 50,
            color:
                selectedMoodIcon == moodName ? color : color.withOpacity(0.5),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color:
                  selectedMoodIcon == moodName ? color : color.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _getMoodName(String iconName) {
    switch (iconName) {
      case 'happy':
        return 'Happy mood';
      case 'neutral':
        return 'Neutral mood';
      case 'sad':
        return 'Sad mood';
      case 'angry':
        return 'Angry mood';
      default:
        return 'Mood';
    }
  }

  IconData _getMoodIcon(String iconName) {
    switch (iconName) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'neutral':
        return Icons.sentiment_satisfied;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      case 'angry':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}
