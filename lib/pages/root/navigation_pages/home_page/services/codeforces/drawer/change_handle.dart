import 'package:flutter/material.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/components/codeforces_textfield.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/components/codeforces_button.dart';

import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/codeforces.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/database_service.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';

class ChangeHandle extends StatefulWidget {  

  const ChangeHandle({super.key});

  @override
  State<ChangeHandle> createState() => _AppbarActionState();
}

class _AppbarActionState extends State<ChangeHandle> {
  final DatabaseService _database = DatabaseService();
  final TextEditingController _handleController = TextEditingController();

  bool isValidating = false;
  bool isValid = false;

  void checkValidity(BuildContext context) async {
    isValidating = true;
    setState(() {});
    CodeforcesApi codeforcesApi = CodeforcesUser();
    isValid = await codeforcesApi.checkValidity(_handleController.text);
    isValidating = false;
    if (!mounted) return;

    if (isValid) {
      // ignore: use_build_context_synchronously
      setName(context);
    } else{
      _handleController.text = "handle doesn't exist";
      setState(() {});
    }
  }

  void setName(BuildContext context) async {
    await _database.setHandle(_handleController.text);    
    changeRoute(context); // ignore: use_build_context_synchronously
  }

  void changeRoute(BuildContext context) {
    FocusScope.of(context).unfocus();

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Codeforces()));
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

              CodeforcesTextfield(
                controller: _handleController,
                hintText: "handle name",
                obscureText: false
              ),
              const SizedBox(height: 15.0),

              CodeforcesButton(
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