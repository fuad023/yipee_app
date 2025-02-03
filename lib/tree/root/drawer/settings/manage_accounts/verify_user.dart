import 'package:flutter/material.dart';
import 'package:student_app/tree/root/drawer/settings/manage_accounts/active_textField.dart';
import 'package:student_app/tree/root/drawer/settings/manage_accounts/user_service.dart';

class VerifyUser extends StatefulWidget {

  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final UserService _userService = UserService();
  final TextEditingController _passwordController = TextEditingController();
  
  void userVerification(BuildContext context) async {
    if(_passwordController.text.isNotEmpty) {
      try{
        final userEmail = _userService.getCurrentUserEmail();
        await _userService.verifyUser(userEmail, _passwordController.text);
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verified Successfully!'),
          backgroundColor: Colors.green,
        )
      );
        }
      } catch (e) {
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to verify!'),
          backgroundColor: Colors.red,
        )
      );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter password'),
          backgroundColor: Colors.red,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.green.shade200,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Verification',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter password for verfication: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20,),
              const ActiveTextfield(
                labelText: 'Password',
                obsecureText: true,
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextButton(
                  onPressed: () => userVerification(context),
                  child: const Text(
                    'Confirm password',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}