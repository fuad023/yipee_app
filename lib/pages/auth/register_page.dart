import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  void register(BuildContext context) async {
    final auth = AuthServices();

    if (_passwordController.text == _confirmpasswordController.text) {
      try {
        await auth.signUpwithEmailandPassword(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You can now log in to your account.'),
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(e
                .toString()), // Consider handling Firebase errors more gracefully.
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Passwords do not match'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Flexible(
              flex: 1, // Adjust flex as needed
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
            const SizedBox(height: 50.0),

            // Welcome Text
            Text(
              'Welcome to the new experience!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16.0,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 25.0),

            // Email TextField
            MyTextfield(
              controller: _emailController,
              hintText: 'Email',
              obscureText: true,
            ),
            const SizedBox(height: 10.0),

            // Password TextField
            MyTextfield(
              controller: _passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 10.0),

            // Confirm Password TextField
            MyTextfield(
              controller: _confirmpasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),
            const SizedBox(height: 25.0),

            // Register Button
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            const SizedBox(height: 25.0),

            // Sign-in Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.grey[600], letterSpacing: 0.5),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Sign in here',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
