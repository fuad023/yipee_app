import 'package:flutter/material.dart';
import 'package:student_app/pages/root.dart';
import 'package:student_app/pages/loading.dart';
import 'package:student_app/pages/home.dart';
import 'package:student_app/pages/chat.dart';
import 'package:student_app/pages/emergency.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const RootPage(),
        '/loading': (context) => const LoadingPage(),
        '/home': (context) => const HomePage(),
        '/chat': (context) => const ChatPage(),
        '/emergency': (context) => const EmergencyPage(),
      },
    )
  );
}
