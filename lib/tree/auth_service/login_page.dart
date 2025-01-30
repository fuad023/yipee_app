import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/components/login_textfield.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_pages/developer_handle.dart';
import 'package:student_app/tree/auth_service/login_pages/forgot_password.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final Function()? onTap;

  void signUserIn(BuildContext context) async {
    final authService = AuthServices();

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
      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
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
                height: MediaQuery.sizeOf(context).height * 1.0,
                width: MediaQuery.sizeOf(context).width * 1.0,
                fit: BoxFit.cover,
                alignment: const Alignment(0.0, 0.0),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeveloperHandle()
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.developer_board,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
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
                        Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: const Text(
                            'Email',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                    
                        // TextField
                        LoginTextfield(
                          hitText: 'user@gmail.com',
                          secureText: false,
                          controlText: _emailController,
                          focusNode: emailFocusNode,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                    
                        // Icon/Text
                        Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.62,
                          ),
                          child: const Text(
                            'Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                    
                        // TextField
                        LoginTextfield(
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
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.45,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    
                        // Button
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.05,
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: MediaQuery.sizeOf(context).height * 0.05,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
