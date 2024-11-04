import 'package:flutter/material.dart';

class QuizGameScreen extends StatefulWidget {
  const QuizGameScreen({super.key});

  @override
  _QuizGameScreenState createState() => _QuizGameScreenState();
}

class _QuizGameScreenState extends State<QuizGameScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What color is the sky?',
      'options': ['Blue', 'Green', 'Red'],
      'answer': 'Blue'
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['3', '4', '5'],
      'answer': '4'
    },
    {
      'question': 'Which animal is known as the "King of the Jungle"?',
      'options': ['Elephant', 'Tiger', 'Lion'],
      'answer': 'Lion'
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'options': ['Earth', 'Jupiter', 'Mars'],
      'answer': 'Jupiter'
    },
    {
      'question': 'Which element has the chemical symbol "O"?',
      'options': ['Oxygen', 'Gold', 'Hydrogen'],
      'answer': 'Oxygen'
    }
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizComplete = false;

  void _selectAnswer(String answer) {
    if (answer == _questions[_currentQuestionIndex]['answer']) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex + 1 < _questions.length) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _isQuizComplete = true;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
      _isQuizComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Game')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isQuizComplete
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz Complete!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your score: $_score',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _restartQuiz,
                      child: const Text('Play Again'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _questions[_currentQuestionIndex]['question'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ..._questions[_currentQuestionIndex]['options']
                        .map<Widget>((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          onPressed: () => _selectAnswer(option),
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    Text(
                      'Score: $_score',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
