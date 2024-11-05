import 'package:flutter/material.dart';
import 'dart:async';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<IconData> _icons = [
    Icons.star,
    Icons.star,
    Icons.favorite,
    Icons.favorite
  ];
  List<bool> _revealed = List.filled(4, false);
  int _firstCardIndex = -1;

  void _flipCard(int index) {
    if (!_revealed[index]) {
      setState(() {
        _revealed[index] = true;
      });

      if (_firstCardIndex == -1) {
        _firstCardIndex = index;
      } else {
        if (_icons[_firstCardIndex] != _icons[index]) {
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              _revealed[_firstCardIndex] = false;
              _revealed[index] = false;
              _firstCardIndex = -1;
            });
          });
        } else {
          _firstCardIndex = -1;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Game')),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _icons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _flipCard(index),
            child: Card(
              color: _revealed[index] ? Colors.blue[100] : Colors.blue,
              child: _revealed[index]
                  ? Icon(_icons[index], size: 48)
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
