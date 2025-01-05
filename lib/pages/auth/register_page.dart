import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';


class RegisterPage extends StatelessWidget {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final void Function()? onTap; 

  void register(BuildContext context) {
    final auth = AuthServices();

    if(_passwordController.text == _confirmpasswordController.text) {
      try {
        auth.signUpwithEmailandPassword(_usernameController.text, _passwordController.text);
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
          builder: (context) => AlertDialog(
            title: Text('Pass dont match'),
          )
      );
    }
  }

  RegisterPage({
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
            children: [
              const SizedBox(height: 50.0),
              
              // here will be our app logo
              Container(
                height: 128.0,
                width: 128.0,
                decoration: const BoxDecoration(
                  // image: DecorationImage(image: AssetImage('assets/katz.jpg'))
                ),
                child: const CircleAvatar(backgroundImage: AssetImage('assets/katz.jpg')),
              ),
              const SizedBox(height: 50.0),

              Text(
                'Welcome to the new experience!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16.0,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 25.0),

              // username textfield
              MyTextfield(
                controller: _usernameController,
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 10.0),
              
              // email textfield
              MyTextfield(
                controller: _usernameController,
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

              //// confirmpassword textfield
              MyTextfield(
                controller: _confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 15.0),

              MyButton(
                text: 'Register',
                onTap: () => register(context),
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
                        'Already have an account? Sign in ',
                        style: TextStyle(color: Colors.grey[600], letterSpacing: 0.5),
                      ),
                    ),

                    GestureDetector(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          'here',
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
      ),
    );
  }
}