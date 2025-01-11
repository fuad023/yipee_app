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
          context: context, // ignore: use_build_context_synchronously
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
            const Icon(Icons.account_circle_sharp),
            const SizedBox(height: 25,),

            const Text('Create an Account'),
            const SizedBox(height: 20,),

            MyTextfield(controller: _emailController, hintText: 'Email', obscureText: false, focusNode: null,),
            const SizedBox(height: 15,),

            MyTextfield(controller: _passwordController, hintText: 'Password', obscureText: true, focusNode: null,),
            const SizedBox(height: 15,),

            MyTextfield(controller: _cpasswordController, hintText: 'Confirm Password', obscureText: true, focusNode: null,),
            const SizedBox(height: 15,),

            MyButton(text: 'Register', onTap: () => register(context)),
            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an Account'),
                const SizedBox(width: 5,),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
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