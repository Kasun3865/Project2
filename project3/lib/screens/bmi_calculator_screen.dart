import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
      });
    } else {
      setState(() {
        _bmi = null; // Reset BMI if input is invalid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center align children
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the content vertically
          children: [
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 16),
            if (_bmi != null)
              Text(
                'Your BMI: ${_bmi!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
