import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/login_page.dart';
import 'package:student_app/pages/auth/register_page.dart';

class LoginOrReg extends StatefulWidget {
  const LoginOrReg({super.key});

  @override
  State<LoginOrReg> createState() => _LoginOrRegState();
}

class _LoginOrRegState extends State<LoginOrReg> {

  bool showHome = true;

  void togglePages() {
    setState(() {
      showHome = !showHome;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showHome) {
      return LoginPage(onTap: togglePages,);
    } else {
      return RegisterPage(onTap: togglePages,);
    }
  }
}