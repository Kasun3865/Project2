import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmergencyContactScreen extends StatefulWidget {
  @override
  _EmergencyContactScreenState createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> _contacts = [];

  String _name = '';
  String _phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('contacts')
            .get();

        setState(() {
          _contacts.addAll(snapshot.docs
              .map((doc) => {
                    'name': doc['name'] as String,
                    'phoneNumber': doc['phoneNumber'] as String,
                  })
              .toList());
        });
      } catch (e) {
        print('Failed to fetch contacts: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch contacts')),
        );
      }
    }
  }

  Future<void> _addContact() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          final docRef = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('contacts')
              .add({
            'name': _name,
            'phoneNumber': _phoneNumber,
          });

          setState(() {
            _contacts.add({
              'name': _name,
              'phoneNumber': _phoneNumber,
            });
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Contact added successfully')),
          );
        } catch (e) {
          print('Failed to add contact: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add contact')),
          );
        }
      }

      _formKey.currentState!.reset();
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
        title: Text('Emergency Contact',
            style: TextStyle(color: Colors.green[700])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person, color: Colors.green[700]),
                    title: Text(_contacts[index]['name'] ?? ''),
                    subtitle: Text(_contacts[index]['phoneNumber'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.phone, color: Colors.green[700]),
                      onPressed: () {
                        // Implement call functionality here
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text('Create a contact',
                style: TextStyle(fontSize: 16, color: Colors.green[700])),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (value) {
                      _name = value ?? '';
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      _phoneNumber = value ?? '';
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addContact,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
