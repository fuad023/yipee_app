import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/login_authentication/login_or_reg.dart';
import 'package:student_app/pages/auth/login_page.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/home.dart';

class ConfirmPassword extends StatefulWidget {

  ConfirmPassword({super.key,});

  @override
  State<ConfirmPassword> createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  final AuthServices _authServices = AuthServices();

  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController _passwordController = TextEditingController();

  // Delete Account
  void deleteAccount(BuildContext context) async {
    await _authServices.deleteAccount(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    String userName = user?.email?? 'No username';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Authority',
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userName,
            style: const TextStyle(
              color: Colors.red
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              fillColor: Colors.red
            ),
          ),
          TextButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Sure Want to Delete Account?'
                  ),
                  actions: [
                    TextButton(onPressed: () {_authServices.deleteAccount(_passwordController.text); Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginOrReg()));}, child: const Text('Ok')),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Cancel')),
                  ],
                );
              },
            )
            ,
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}