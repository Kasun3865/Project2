import 'package:flutter/material.dart';
import 'memory_game_screen.dart'; // Import Memory Game Screen
import 'breathing_exercise_screen.dart'; // Import Breathing Exercise Screen
import 'puzzle_game_screen.dart'; // Import Puzzle Game Screen
import 'quiz_game_screen.dart'; // Import Quiz Game Screen

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games to Relax'),
        backgroundColor: Colors.teal,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGameCard(
              context, 'Memory Game', Icons.memory, _startMemoryGame),
          _buildGameCard(context, 'Breathing Exercise', Icons.self_improvement,
              _startBreathingExercise),
          _buildGameCard(
              context, 'Puzzle Game', Icons.extension, _startPuzzleGame),
          _buildGameCard(context, 'Quiz Game', Icons.quiz, _startQuizGame),
        ],
      ),
    );
  }

  Widget _buildGameCard(
      BuildContext context, String title, IconData icon, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Card(
        color: Colors.lightGreen[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.teal),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  void _startMemoryGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemoryGameScreen()),
    );
  }

  void _startBreathingExercise(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BreathingExerciseScreen()),
    );
  }

  void _startPuzzleGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PuzzleGameScreen()),
    );
  }

  void _startQuizGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizGameScreen()),
    );
  }
}
