import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'dart:io';

import 'package:project3/screens/storage_service.dart'; // For file handling
// Import the storage service

class EditAccountScreen extends StatefulWidget {
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '';
  String _profileImageUrl = ''; // To store the profile image URL
  File? _image; // To hold the selected image

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user!.uid).get();
      setState(() {
        _username = doc['username'] ?? '';
        _email = doc['email'] ?? user!.email!;
        _phoneNumber = doc['phone_number'] ?? '';
        _profileImageUrl =
            doc['profile_picture'] ?? ''; // Fetch profile picture URL
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      StorageService storageService = StorageService();
      String downloadUrl =
          await storageService.uploadProfilePicture(_image!, user!.uid);
      setState(() {
        _profileImageUrl = downloadUrl;
      });
      // Update the profile picture URL in Firestore
      await _firestore.collection('users').doc(user!.uid).update({
        'profile_picture': _profileImageUrl,
      });
    }
  }

  Future<void> _updateAccountDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        if (_email != user?.email) {
          await user?.verifyBeforeUpdateEmail(_email);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'A verification email has been sent to $_email. Please verify the new email before proceeding.')),
          );
        }
        if (_password.isNotEmpty) {
          await user?.updatePassword(_password);
        }
        await _firestore.collection('users').doc(user!.uid).update({
          'username': _username,
          'email': _email,
          'phone_number': _phoneNumber,
        });

        // Store a notification in Firestore
        await _firestore
            .collection('users')
            .doc(user?.uid)
            .collection('notifications')
            .add({
          'title': 'Account Information Updated',
          'message': 'Your account details have been successfully updated.',
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account details updated successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Failed to update account details: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update account details.')),
        );
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
        title: Text('Edit Personal Details',
            style: TextStyle(color: Colors.green[700])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Wrap the column with SingleChildScrollView for better layout
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (_profileImageUrl.isNotEmpty
                                  ? NetworkImage(_profileImageUrl)
                                  : AssetImage('assets/default_profile.png'))
                              as ImageProvider,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: _username,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    suffixIcon: Icon(Icons.edit, color: Colors.green[700]),
                  ),
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.edit, color: Colors.green[700]),
                  ),
                  onSaved: (value) {
                    _email = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.edit, color: Colors.green[700]),
                  ),
                  obscureText: true,
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: _phoneNumber,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    suffixIcon: Icon(Icons.edit, color: Colors.green[700]),
                  ),
                  onSaved: (value) {
                    _phoneNumber = value!;
                  },
                ),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await _uploadImage(); // Upload the image before updating the account details
                      _updateAccountDetails();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
