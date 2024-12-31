import 'package:flutter/material.dart';
import 'package:student_app/pages/root.dart';
import 'package:student_app/pages/loading.dart';
import 'package:student_app/pages/navigation.dart';
import 'package:student_app/pages/nagivation_pages/home.dart';
import 'package:student_app/pages/nagivation_pages/chat.dart';
import 'package:student_app/pages/nagivation_pages/emergency.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':                     (context) => const RootPage(),
        '/loading':              (context) => const LoadingPage(),
        '/navigation':           (context) => const Navigation(),
        '/navigation/home':      (context) => const HomePage(),
        '/navigation/chat':      (context) => const ChatPage(),
        '/navigation/emergency': (context) => const EmergencyPage(),
      },
    )
  );
}