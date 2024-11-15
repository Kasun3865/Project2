import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<List<DocumentSnapshot>> _fetchNotifications() async {
    if (user != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .get();
      return querySnapshot.docs;
    }
    return [];
  }

  Future<void> _markAsRead(List<DocumentSnapshot> notifications) async {
    if (user != null) {
      for (var doc in notifications) {
        if (doc['read'] == false) {
          await doc.reference.update({'read': true});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green[700]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            Text('Notifications', style: TextStyle(color: Colors.green[700])),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load notifications.'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          } else {
            List<DocumentSnapshot> notifications = snapshot.data ?? [];

            // Mark all unread notifications as read
            _markAsRead(notifications);

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading:
                        Icon(Icons.notifications, color: Colors.green[700]),
                    title: Text(notifications[index]['title'] ?? 'No title'),
                    subtitle:
                        Text(notifications[index]['message'] ?? 'No message'),
                    trailing: Icon(Icons.access_time, color: Colors.green[700]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
