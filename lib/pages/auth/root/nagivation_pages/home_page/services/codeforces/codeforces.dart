import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';

class Codeforces extends StatelessWidget {
  final TextEditingController _handlerName = TextEditingController();

  Codeforces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Codeforces"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
      ),
      body: _searchUser(),
    );
  }

  Widget _searchUser() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextfield(
            controller: _handlerName,
            hintText: "Handler name",
            obscureText: false
          ),
          MyButton(
            text: "Search",
            onTap: () {}
          ),
        ],
      ),
    );
  }
}