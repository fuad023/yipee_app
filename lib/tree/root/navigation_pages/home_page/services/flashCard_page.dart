// ignore: file_names
import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final List<Map<String, String>> flashcards = [
    {"question": " What is the chemical symbol for water?", "answer": "H₂O"},
    {"question": "What is the square root of 144?", "answer": "12"},
    {"question": " What is the capital of France?", "answer": "Paris"},
  ];

  int _currentIndex = 0;
  bool _showAnswer = false;

  void _nextCard() {
    setState(() {
      if (_currentIndex < flashcards.length - 1) {
        _currentIndex++;
        _showAnswer = false;
      }
    });
  }

  void _prevCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _showAnswer = false;
      }
    });
  }

  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 240, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        title: const Text('Flashcards')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _flipCard,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: 300,
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  _showAnswer ? flashcards[_currentIndex]["answer"]! : flashcards[_currentIndex]["question"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _prevCard,
                child: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _nextCard,
                child: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ],
      ),
    );
  }
}