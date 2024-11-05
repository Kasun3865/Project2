// health_tracker_screen.dart
import 'package:flutter/material.dart';
import 'health_metric.dart'; // Import your HealthMetric model

class HealthTrackerScreen extends StatefulWidget {
  @override
  _HealthTrackerScreenState createState() => _HealthTrackerScreenState();
}

class _HealthTrackerScreenState extends State<HealthTrackerScreen> {
  final List<HealthMetric> metrics = []; // List to store health metrics
  final TextEditingController _valueController = TextEditingController();
  String _selectedMetric = 'Weight'; // Default metric type

  void _addMetric() {
    final value = double.tryParse(_valueController.text);
    if (value != null) {
      setState(() {
        metrics.add(HealthMetric(
          type: _selectedMetric,
          value: value,
          date: DateTime.now(),
        ));
        _valueController.clear(); // Clear input field after adding
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedMetric,
              onChanged: (value) {
                setState(() {
                  _selectedMetric = value!;
                });
              },
              items: <String>['Weight', 'Blood Pressure', 'Glucose']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Value'),
            ),
            ElevatedButton(
              onPressed: _addMetric,
              child: const Text('Add Metric'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: metrics.length,
                itemBuilder: (context, index) {
                  final metric = metrics[index];
                  return ListTile(
                    title: Text('${metric.type}: ${metric.value}'),
                    subtitle: Text('${metric.date}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
