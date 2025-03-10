import 'dart:async';

import 'package:flutter/material.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  static const int studyTime = 25 * 60; // 25 minutes in seconds
  static const int breakTime = 5 * 60; // 5 minutes in seconds

  int _remainingTime = studyTime;
  bool _isRunning = false;
  bool _isStudySession = true;
  Timer? _timer;

  void _startPauseTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingTime > 0) {
          setState(() {
            _remainingTime--;
          });
        } else {
          _switchSession();
        }
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = _isStudySession ? studyTime : breakTime;
      _isRunning = false;
    });
  }

  void _switchSession() {
    setState(() {
      _isStudySession = !_isStudySession;
      _remainingTime = _isStudySession ? studyTime : breakTime;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 240, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        title: const Text('Pomodoro Timer')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _isStudySession ? "Study Time" : "Break Time",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            value: _remainingTime /
                (_isStudySession ? studyTime : breakTime), // Progress
            strokeWidth: 8,
          ),
          const SizedBox(height: 20),
          Text(
            _formatTime(_remainingTime),
            style: const TextStyle(fontSize: 50),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _startPauseTimer,
                child: Text(_isRunning ? "Pause" : "Start"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetTimer,
                child: const Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}