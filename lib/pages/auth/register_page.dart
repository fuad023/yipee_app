import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
    });

  void register(BuildContext context) async {
    final authservices = AuthServices();
    if(_cpasswordController.text == _passwordController.text) {
    try {
      await authservices.signUpwithEmailandPassword(_emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Password not match'),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle_sharp),
            SizedBox(height: 25,),

            Text('Create an Account'),
            SizedBox(height: 20,),

            MyTextfield(controller: _emailController, hintText: 'Email', obscureText: false, focusNode: null,),
            SizedBox(height: 15,),

            MyTextfield(controller: _passwordController, hintText: 'Password', obscureText: true, focusNode: null,),
            SizedBox(height: 15,),

            MyTextfield(controller: _cpasswordController, hintText: 'Confirm Password', obscureText: true, focusNode: null,),
            SizedBox(height: 15,),

            MyButton(text: 'Register', onTap: () => register(context)),
            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an Account'),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}