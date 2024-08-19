import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String _feedback = '';
  int _rating = 0;

  // Method to submit feedback to Firestore
  Future<void> _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Get a reference to the Firestore instance
        CollectionReference feedbackCollection =
            FirebaseFirestore.instance.collection('feedback');

        // Create a new document with the feedback data
        await feedbackCollection.add({
          'feedback': _feedback,
          'rating': _rating,
          'timestamp':
              FieldValue.serverTimestamp(), // to record the time of submission
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thank you for your feedback!')),
        );

        // Optionally, clear the form after submission
        setState(() {
          _feedback = '';
          _rating = 0;
        });
      } catch (e) {
        // Handle errors here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit feedback: $e')),
        );
      }
    }
  }

  Widget _buildStar(int starCount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = starCount;
        });
      },
      child: Icon(
        Icons.star,
        color: starCount <= _rating ? Colors.yellow : Colors.grey,
        size: 40,
      ),
    );
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
        title: Text('Feedback', style: TextStyle(color: Colors.green[700])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Enter your feedback',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _feedback = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitFeedback, // Call the submit feedback method
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Send'),
              ),
              SizedBox(height: 32),
              Text('Rate Us', style: TextStyle(fontSize: 18)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => _buildStar(index + 1)),
              ),
              SizedBox(height: 32),
              Text('Find us on', style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.twitter,
                      size: 40, color: Colors.green[700]),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.facebook,
                      size: 40, color: Colors.green[700]),
                  SizedBox(width: 20),
                  Icon(FontAwesomeIcons.instagram,
                      size: 40, color: Colors.green[700]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
