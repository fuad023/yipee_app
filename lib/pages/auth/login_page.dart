import 'package:flutter/material.dart';
import 'package:student_app/components/login_textField.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final Function()? onTap;

  void signUserIn(BuildContext context) async {
    final authservice = AuthServices();

    try {
      await authservice.signwithEmailandPassword(_emailController.text, _passwordController.text);

    } catch (e) {
      showDialog(
          context: context, // ignore: use_build_context_synchronously
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }

  LoginPage({
    super.key,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Stack(
        children: [
          ClipRRect(
            child: Image.asset(
              'assets/1.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment(0.0, 0.0),
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
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10,),

                // Text
                Text(
                  'Sign in to continue',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 10,),

                // Icon/Text
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Icon
                      Icon(
                        Icons.mail_outline,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10,),

                      // Text
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
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
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Icon
                      Icon(
                        Icons.key_off,
                        size: 24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10,),

                      // Text
                      Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                // TextField
                LoginTextField(
                  hitText: 'password',
                  secureText: true,
                  controlText: _passwordController,
                  focusNode: passwordFocusNode,
                ),
                const SizedBox(height: 10,),

                // Text
                Padding(
                  padding: EdgeInsets.only(left: 200),
                  child: GestureDetector(
                    onTap: () {},
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
                const SizedBox(height: 10,),

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
    );
  }
}

