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
                height: MediaQuery.sizeOf(context).height * 1.0,
                width: MediaQuery.sizeOf(context).width * 1.0,
                fit: BoxFit.cover,
                alignment: const Alignment(0.0, 0.0),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: SingleChildScrollView(
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
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.01,
                    ),
                
                    // Text
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.03,
                    ),
                
                    // Text
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.6,
                      ),
                      child: const Text(
                        'Email',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.01,
                    ),
                
                    // TextField
                    LoginTextField(
                      hitText: 'user@gmail.com',
                      secureText: false,
                      controlText: _emailController,
                      focusNode: emailFocusNode,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.027,
                    ),
                
                    // Icon/Text
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.53,
                      ),
                      child: const Text(
                        'Password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.01,
                    ),
                
                    // TextField
                    LoginTextField(
                      hitText: '********',
                      secureText: true,
                      controlText: _passwordController,
                      focusNode: passwordFocusNode,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.01,
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
                        top: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        //height: MediaQuery.sizeOf(context).height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            signUserIn(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color:Color.fromARGB(255, 14, 73, 56),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height *0.01,
                    ),
                
                    // Row
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height *0.01,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text
                          const Text(
                            'Don\'t have an Account?',
                            style: TextStyle(color: Colors.white38),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.02,
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
      ),
    );
  }
}
