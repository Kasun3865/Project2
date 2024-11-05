import 'package:flutter/material.dart';

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  _BreathingExerciseScreenState createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _breathingStage = 'Inhale';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _breathingStage = _breathingStage == 'Inhale' ? 'Exhale' : 'Inhale';
          });
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breathing Exercise')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_breathingStage, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ScaleTransition(
              scale: Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
                  parent: _controller, curve: Curves.easeInOut)),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.blue[200], shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
