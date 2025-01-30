import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_page.dart';
import 'package:student_app/tree/auth_service/register_page.dart';

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