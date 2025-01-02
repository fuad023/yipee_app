import 'package:flutter/material.dart';
import 'package:student_app/pages/init_page.dart';
import 'package:student_app/pages/loading_page.dart';
import 'package:student_app/pages/auth/login_page.dart';
import 'package:student_app/pages/auth/register_page.dart';
import 'package:student_app/pages/auth/root/root_page.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':         (context) => const InitPage(),
        '/loading':  (context) => const LoadingPage(),        
        '/login':    (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/root':     (context) => const RootPage(),
      },
    )
  );
}