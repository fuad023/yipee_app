import 'package:flutter/material.dart';
import 'package:student_app/components/login_textField.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';
import 'package:student_app/pages/login_pages/forgot_password.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final Function()? onTap;

  void signUserIn(BuildContext context) async {
    final authservice = AuthServices();

    if (_emailController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Please enter email'),
        ),
      );
      return;
    }
    else if (_passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Please enter password'),
        ),
      );
      return;
    }
    
    if(_passwordController.text.length < 8) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Error'),
            content: Text('Password must be at least 8 characters'),
          ),
      );
      return;
    }

    try {
      await authservice.signwithEmailandPassword(_emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context, // ignore: use_build_context_synchronously
          builder: (context) => const AlertDialog(
                title: Text('Error'),
            content: Text('Invalid email/password'),
              ));
    }
  }

  LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF2B5F56),
        body: Stack(
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/1.png',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: const Alignment(0.0, 0.0),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text
                 const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Text
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Icon/Text
                  const Padding(
                    padding: EdgeInsets.only(right: 250),
                    child: Text(
                      'Email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // TextField
                  LoginTextField(
                    hitText: 'user@gmail.com',
                    secureText: false,
                    controlText: _emailController,
                    focusNode: emailFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Icon/Text
                  const Padding(
                    padding: EdgeInsets.only(right: 225),
                    child: Text(
                      'Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // TextField
                  LoginTextField(
                    hitText: '********',
                    secureText: true,
                    controlText: _passwordController,
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Text
                  Padding(
                    padding: EdgeInsets.only(left: 200),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Button
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Container(
                      width: 331.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          signUserIn(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // Row
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text
                        const Text(
                          'Don\'t have an Account?',
                          style: TextStyle(color: Colors.white38),
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        // Register Button
                        GestureDetector(
                          onTap: onTap,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
