import 'package:flutter/material.dart';

class EyeTestScreen extends StatefulWidget {
  const EyeTestScreen({super.key});

  @override
  _EyeTestScreenState createState() => _EyeTestScreenState();
}

class _EyeTestScreenState extends State<EyeTestScreen> {
  double _fontSize = 140.0; // Starting font size
  double _initialFontSize = 140.0; // Store initial font size for reset

  void _increaseFontSize() {
    setState(() {
      // Decrease the font size with each click
      if (_fontSize > 0) {
        // Prevent the font size from going below 0
        _fontSize -= 2.0; // Reduce font size by 2 points
      }
    });
  }

  void _resetFontSize() {
    setState(() {
      _fontSize = _initialFontSize; // Reset to initial font size
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eye Test'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Test Your Eye Here',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'A 3 F e S h 1 R i 8',
                style: TextStyle(fontSize: _fontSize),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _increaseFontSize,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text('Click to Adjust Font Size'),
              ),
              const SizedBox(height: 20),
              Text(
                'Your vision: ${((1 - (_fontSize / _initialFontSize)) * 100).round()}%', // Show font size reduction as a percentage
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetFontSize,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
