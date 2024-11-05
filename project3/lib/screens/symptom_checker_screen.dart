import 'package:flutter/material.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({Key? key}) : super(key: key);

  @override
  _SymptomCheckerScreenState createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  final TextEditingController _symptomController = TextEditingController();
  String _result = '';

  void _checkSymptoms() {
    String symptoms = _symptomController.text.toLowerCase();

    // Basic logic for symptom analysis
    if (symptoms.contains('fever') || symptoms.contains('chills')) {
      setState(() {
        _result = 'You may have the flu. Consider seeing a doctor.';
      });
    } else if (symptoms.contains('cough') && symptoms.contains('sore throat')) {
      setState(() {
        _result = 'You might be experiencing a cold.';
      });
    } else if (symptoms.contains('headache')) {
      setState(() {
        _result = 'It could be a tension headache. Stay hydrated.';
      });
    } else {
      setState(() {
        _result = 'Please consult a medical professional for proper advice.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _symptomController,
              decoration: InputDecoration(
                labelText: 'Describe your symptoms',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkSymptoms,
              child: const Text('Check Symptoms'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
