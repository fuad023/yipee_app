import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/codeforces.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/database_service.dart';

class AppbarAction extends StatelessWidget {  
  final DatabaseService _database = DatabaseService();
  final TextEditingController _handleController = TextEditingController();

  AppbarAction({super.key});

  void setName(BuildContext context) async {
    await _database.setHandle(_handleController.text);    
    // ignore: use_build_context_synchronously
    changeRoute(context);
  }

  void changeRoute(BuildContext context) {
    FocusScope.of(context).unfocus();

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Codeforces(handle: "",)));
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

      body: Center(
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
                controller: _handleController,
                hintText: "handle name",
                obscureText: false
              ),
              const SizedBox(height: 15.0),

              MyButton(
                text: "S  E  T",
                onTap: () => setName(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}