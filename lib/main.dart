import 'package:flutter/material.dart';
import 'package:student_app/pages/init_page.dart';
import 'package:student_app/pages/loading_page.dart';
import 'package:student_app/pages/root_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':        (context) => const InitPage(),
        '/loading': (context) => const LoadingPage(),
        '/root':    (context) => const RootPage(),
      },
    )
  );
}