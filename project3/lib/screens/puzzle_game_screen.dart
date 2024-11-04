import 'package:flutter/material.dart';

class PuzzleGameScreen extends StatefulWidget {
  const PuzzleGameScreen({super.key});

  @override
  _PuzzleGameScreenState createState() => _PuzzleGameScreenState();
}

class _PuzzleGameScreenState extends State<PuzzleGameScreen> {
  List<int> puzzlePieces =
      List.generate(8, (index) => index + 1) + [0]; // 0 as the empty space

  @override
  void initState() {
    super.initState();
    puzzlePieces.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Arrange the numbers in order!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildPuzzleGrid(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _restartPuzzle,
            child: const Text('Restart Puzzle'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Builds a simple 3x3 grid for the puzzle pieces.
  Widget _buildPuzzleGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: puzzlePieces.length,
        itemBuilder: (context, index) {
          return _buildPuzzleTile(puzzlePieces[index], index);
        },
      ),
    );
  }

  // A tile that can be moved if adjacent to the empty space.
  Widget _buildPuzzleTile(int number, int index) {
    bool isEmpty = number == 0;
    return GestureDetector(
      onTap: () => _moveTile(index),
      child: Container(
        decoration: BoxDecoration(
          color: isEmpty ? Colors.transparent : Colors.teal[100],
          borderRadius: BorderRadius.circular(8),
          boxShadow: isEmpty
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            isEmpty ? '' : number.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Method to move a tile if it's adjacent to the empty slot.
  void _moveTile(int index) {
    int emptyIndex = puzzlePieces.indexOf(0);

    // Check if the tapped tile is adjacent to the empty tile.
    if (_isAdjacent(index, emptyIndex)) {
      setState(() {
        puzzlePieces[emptyIndex] = puzzlePieces[index];
        puzzlePieces[index] = 0;
      });
    }
  }

  // Check if two indices in a 3x3 grid are adjacent.
  bool _isAdjacent(int index, int emptyIndex) {
    // Define the possible moves based on a 3x3 grid layout
    const gridSize = 3;
    int rowDifference =
        (index / gridSize - emptyIndex / gridSize).abs().toInt();
    int colDifference = (index % gridSize - emptyIndex % gridSize).abs();

    return (rowDifference + colDifference) == 1;
  }

  // Restart the puzzle by shuffling pieces.
  void _restartPuzzle() {
    setState(() {
      puzzlePieces.shuffle();
    });
  }
}
