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
    if(_confirmPasswordController.text == _passwordController.text) {
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
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  //const SizedBox(height: 10,),
      
                  // Text
                  Text(
                    'Sign up to continue',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 10,),
      
                  // Icon/Text
                  const Padding(
                    padding: EdgeInsets.only(right: 250),
                    child: Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                  ),
                  const SizedBox(height: 10,),
      
                  // TextField
                  LoginTextField(
                    hitText: 'user@gmail.com',
                    secureText: false,
                    controlText: _emailController,
                    focusNode: emailFocusNode,
                  ),
                  const SizedBox(height: 10,),
      
                  // Text/Icon
                  const Padding(
                    padding: EdgeInsets.only(right: 225),
                    child: Text(
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
                  const SizedBox(height: 10,),
      
                  // Text/Icon
                  const Padding(
                    padding: EdgeInsets.only(right: 175),
                    child: Text(
                          'Confirm Password',
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
                    controlText: _confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                  ),
                  const SizedBox(height: 10,),
      
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
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text
                        Text(
                          'Already have an Account?',
                          style: TextStyle(
                              color: Colors.white38
                          ),
                        ),
                        const SizedBox(width: 10,),
      
                        // Register Button
                        GestureDetector(
                          onTap: onTap,
                          child: Text(
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
          ],
        ),
      ),
    );
  }
}
