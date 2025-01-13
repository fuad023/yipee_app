import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/codeforces.dart';

class AppbarAction extends StatelessWidget {
  final TextEditingController _handlerName = TextEditingController();

  AppbarAction({super.key});

  void pushHandle(BuildContext context, String handle) {
    FocusScope.of(context).unfocus();

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Codeforces(handle: handle)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],

      appBar: AppBar(
        title: const Text("Go back?"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
      ),

      body: SafeArea(
        child: Center(
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
                  obscureText: false
                ),
            
                const SizedBox(height: 15.0),
            
                MyButton(
                  text: "Set Handle",
                  onTap: () => pushHandle(context, _handlerName.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}