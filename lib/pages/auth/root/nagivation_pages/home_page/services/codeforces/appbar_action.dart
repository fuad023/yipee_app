import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/codeforces.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/database_service.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/cf_user_info.dart';

class AppbarAction extends StatefulWidget {  

  const AppbarAction({super.key});

  @override
  State<AppbarAction> createState() => _AppbarActionState();
}

class _AppbarActionState extends State<AppbarAction> {
  final DatabaseService _database = DatabaseService();
  final TextEditingController _handleController = TextEditingController();

  bool isValidating = false;
  bool isValid = false;

  void checkValidity(BuildContext context) async {
    isValidating = true;
    setState(() {});
    CodeforcesApi codeforcesApi = CfGetUserInfo();
    isValid = await codeforcesApi.checkValidity(_handleController.text);
    isValidating = false;
    setName(context); // ignore: use_build_context_synchronously
  }

  void setName(BuildContext context) async {
    await _database.setHandle(_handleController.text);    
    changeRoute(context); // ignore: use_build_context_synchronously
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

      body: isValidating 
        ? const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          )
        ) 
        : Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Set up handle here",
                style: TextStyle(
                  color: Colors.green[900],
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
                onTap: () => checkValidity(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}