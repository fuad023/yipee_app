import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/login_or_reg.dart';
import 'package:student_app/tree/root/root_page.dart';

class AuthGet extends StatelessWidget {
  const AuthGet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return const RootPage();
          } else {
            return const LoginOrReg();
          }
        },
      ),
    );
  }
}