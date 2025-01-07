import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  void signUserIn(BuildContext context) async {
    final authservice = AuthServices();

    try {
      await authservice.signwithEmailandPassword(_emailController.text, _passwordController.text);

    } catch (e) {
      throw Exception(e);
    }
  }

  LoginPage({
    super.key,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // here will be our app logo
              Flexible(
              flex: 2, // Adjust flex as needed
              child: Container(
                height: 128.0,
                width: 128.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/katz.jpg'),
                ),
              ),
            ),
              const SizedBox(height: 25.0),

              Text(
                'Welcome back! You\'ve been missed.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 20.0),

              // userinfo textfield
              // Email TextField
            MyTextfield(
              controller: _emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 10.0),

              // password textfield
              MyTextfield(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 15.0),

              //forgot password
              Padding(
                padding: const EdgeInsets.only(right: 26.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot password?',
                      style: TextStyle(color: Colors.grey[600], letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              MyButton(
                text: 'Sign in',
                onTap: () => signUserIn(context),
              ),
              const SizedBox(height: 25.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.green,
                      )
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Don\'t have an account? ',
                        style: TextStyle(color: Colors.grey[600], letterSpacing: 0.5),
                      ),
                    ),

                    GestureDetector(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                
                    const Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.green,
                      )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}