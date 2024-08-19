import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project3/screens/notifications_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'my_account_screen.dart'; // Import the My Account screen
import 'feedback_screen.dart'; // Import the FeedbackScreen
import 'emergency_contact_screen.dart'; // Import the EmergencyContactScreen

class MoodLoggingScreen extends StatefulWidget {
  @override
  _MoodLoggingScreenState createState() => _MoodLoggingScreenState();
}

class _MoodLoggingScreenState extends State<MoodLoggingScreen> {
  int _notificationCount = 0;

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

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Month',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return Column(
                  children: [
                    Text(
                      'S M T W T F S'.split(' ')[index],
                      style: TextStyle(
                        color: Colors.green[700],
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Text(
                        '${index + 7}',
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'How do you feel today?',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Logic to log the mood
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.green[700]),
                          SizedBox(width: 10),
                          Text(
                            'Log your mood...',
                            style: TextStyle(
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write how you feel today...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
}
