import 'package:flutter/material.dart';
import 'package:student_app/components/login_textField.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';


class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final Function()? onTap;

  void register(BuildContext context) async {
    final authservices = AuthServices();

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

    if (_passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Please enter password'),
        ),
      );
      return;
    }

    if (_confirmPasswordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Please confirm password'),
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

    if(_confirmPasswordController.text == _passwordController.text) {
    try {
      await authservices.signUpwithEmailandPassword(_emailController.text, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context, // ignore: use_build_context_synchronously
          builder: (context) => const AlertDialog(
            title: Text('Error'),
            content: Text('Couldn\'t Signup'),
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

  RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
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
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                      
                    // Text
                    const Text(
                      'Sign up to continue',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.03,),
                      
                    // Icon/Text
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.6,),
                      child: const Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
                      
                    // TextField
                    LoginTextField(
                      hitText: 'user@gmail.com',
                      secureText: false,
                      controlText: _emailController,
                      focusNode: emailFocusNode,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
                      
                    // Text/Icon
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.52,),
                      child: const Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                    ),
                    const SizedBox(height: 10,),
                      
                    // TextField
                    LoginTextField(
                      hitText: '********',
                      secureText: true,
                      controlText: _passwordController,
                      focusNode: passwordFocusNode,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
                      
                    // Text/Icon
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.37,),
                      child: const Text(
                            'Confirm Password',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.01,),
                      
                    // TextField
                    LoginTextField(
                      hitText: '********',
                      secureText: true,
                      controlText: _confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                    ),
                    const SizedBox(height: 10,),
                      
                    // Button
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.03,),
                      child: Container(
                        width: 331.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            register(context);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //const SizedBox(height: 10,),
                      
                    // Row
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.02,),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text
                          const Text(
                            'Already have an Account?',
                            style: TextStyle(
                                color: Colors.white38
                            ),
                          ),
                          SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                      
                          // Register Button
                          GestureDetector(
                            onTap: onTap,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
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
