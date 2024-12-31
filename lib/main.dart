import 'package:flutter/material.dart';
import 'package:student_app/pages/root.dart';
import 'package:student_app/pages/loading.dart';
import 'package:student_app/pages/navigation.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':                     (context) => const RootPage(),
        '/loading':              (context) => const LoadingPage(),
        '/navigation':           (context) => const Navigation(),
      },
    )
  );
}