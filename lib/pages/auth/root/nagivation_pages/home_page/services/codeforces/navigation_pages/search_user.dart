import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';

class SearchUser extends StatelessWidget {
  final TextEditingController _handlerName = TextEditingController();

  SearchUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Set up handle here",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                letterSpacing: 1.5,
              )
            ),

            const SizedBox(height: 15.0),

            MyTextfield(
                controller: _handlerName,
                hintText: "handle name",
                obscureText: false),
            const SizedBox(height: 15.0),
            MyButton(
              text: "Set Handle",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}