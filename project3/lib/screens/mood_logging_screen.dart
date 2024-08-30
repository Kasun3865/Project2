// screens/mood_logging_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/screens/notifications_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'my_account_screen.dart'; // Import the My Account screen
import 'feedback_screen.dart'; // Import the FeedbackScreen
import 'emergency_contact_screen.dart'; // Import the EmergencyContactScreen
import '../models/mood.dart'; // Import Mood model
import '../models/mood_provider.dart'; // Import MoodProvider
import 'package:provider/provider.dart'; // Import Provider

class MoodLoggingScreen extends StatefulWidget {
  @override
  _MoodLoggingScreenState createState() => _MoodLoggingScreenState();
}

class _MoodLoggingScreenState extends State<MoodLoggingScreen> {
  int _notificationCount = 0;
  String? selectedMoodIcon; // New state to hold selected mood icon
  final TextEditingController noteController =
      TextEditingController(); // For notes

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
        moodType: _getMoodName(selectedMoodIcon!), // Set mood type dynamically
        note: noteController.text,
        icon: selectedMoodIcon!, // Store the selected mood icon
      );

      // Add the new mood to the provider or database.
      Provider.of<MoodProvider>(context, listen: false).addMood(newMood);

      // Clear the input fields after saving
      setState(() {
        selectedMoodIcon = null;
        noteController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mood saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final moods =
        Provider.of<MoodProvider>(context).moods; // Access the mood history

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
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.green[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select your mood:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMoodIcon(
                      'happy', Icons.sentiment_very_satisfied, 'Happy'),
                  _buildMoodIcon(
                      'neutral', Icons.sentiment_satisfied, 'Neutral'),
                  _buildMoodIcon('sad', Icons.sentiment_dissatisfied, 'Sad'),
                  _buildMoodIcon(
                      'angry', Icons.sentiment_very_dissatisfied, 'Angry'),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Add a note (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMood,
                child: Text('Save Mood'),
              ),
              SizedBox(height: 20),
              Divider(), // Separator
              SizedBox(height: 20),
              Text('Mood History:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  // Reverse the list to display the newest first
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
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmergencyContactScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedbackScreen()),
            );
          }
        },
        items: [
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
            icon: Icon(Icons.star), // Feedback icon
            label: 'Feedback',
          ),
        ],
      ),
    );
  }

  // Helper method to build mood icon with label
  Widget _buildMoodIcon(String moodName, IconData iconData, String label) {
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
            size: 50, // Increase the size of the icons
            color: selectedMoodIcon == moodName ? Colors.green : Colors.grey,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: selectedMoodIcon == moodName ? Colors.green : Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get mood name based on selected icon
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

  // Helper method to map mood icon names to IconData
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
