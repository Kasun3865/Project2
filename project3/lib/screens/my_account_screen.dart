import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_account_screen.dart'; // Import the edit account screen

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      if (user != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user!.uid).get();

        if (doc.exists && doc.data() != null) {
          setState(() {
            userData = doc.data() as Map<String, dynamic>?;
          });
        } else {
          setState(() {
            userData = {}; // Set userData as an empty map to indicate no data
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user data found.')),
          );
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to fetch user data. Please try again later.')),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      await _firestore.collection('users').doc(user!.uid).delete();
      await user!.delete();
      FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account.')),
      );
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
        title: Text('My Account', style: TextStyle(color: Colors.green[700])),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : userData!.isEmpty
              ? Center(
                  child: Text(
                    'No user data available.',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.green[200],
                          child: Icon(Icons.person,
                              size: 50, color: Colors.green[700]),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userData?['username'] ?? 'User Name',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700]),
                        ),
                        SizedBox(height: 10),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email, color: Colors.green[700]),
                            SizedBox(width: 10),
                            Text(
                              user?.email ?? 'xxxxx@xxxxx.com',
                              style: TextStyle(color: Colors.green[700]),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, color: Colors.green[700]),
                            SizedBox(width: 10),
                            Text(
                              userData?['phone_number'] ?? 'Phone Number',
                              style: TextStyle(color: Colors.green[700]),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccountScreen()),
                            );
                          },
                          icon: Icon(Icons.edit, color: Colors.white),
                          label: Text('Edit Account Details'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _deleteAccount,
                          icon: Icon(Icons.delete, color: Colors.white),
                          label: Text('Delete Account'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}