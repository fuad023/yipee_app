import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/components/login_textfield.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';


class RegisterPage extends StatelessWidget {
  final TextEditingController _profileNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode profileNameFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();

  final Function()? onTap;

  UserCredentials convertToUserCredentials() {
    return UserCredentials(profileName: _profileNameController.text, userName: _userNameController.text, email: _emailController.text);
  }

  void register(BuildContext context) async {
    final authservices = AuthServices();
    final UserCredentials usercredentials = convertToUserCredentials();

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
      await authservices.signUpWithEmailAndPassword(usercredentials, _passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Error'),
            content: Text('Could not Signup'),
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
                height: double.infinity,
                width: double.infinity,
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
                    //const SizedBox(height: 10,),
                      
                    // Text
                    const Text(
                      'Sign up to continue',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                
                    const SizedBox(height: 10,),
                      
                    // Icon/Text
                    const Padding(
                      padding: EdgeInsets.only(right: 190),
                      child: Text(
                            'Profile Name',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                    ),
                    const SizedBox(height: 10,),
                      
                    // TextField
                    LoginTextfield(
                      hitText: 'Profile Name',
                      secureText: false,
                      controlText: _profileNameController,
                      focusNode: profileNameFocusNode,
                    ),
                
                    const SizedBox(height: 10,),
                      
                    // Icon/Text
                    const Padding(
                      padding: EdgeInsets.only(right: 210),
                      child: Text(
                            'User Name',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                    ),
                    const SizedBox(height: 10,),
                      
                    // TextField
                    LoginTextfield(
                      hitText: 'user_name',
                      secureText: false,
                      controlText: _userNameController,
                      focusNode: userNameFocusNode,
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
                    LoginTextfield(
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
                    LoginTextfield(
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
                    LoginTextfield(
                      hitText: '********',
                      secureText: true,
                      controlText: _confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                    ),
                    const SizedBox(height: 10,),
                      
                    // Button
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                          const Text(
                            'Already have an Account?',
                            style: TextStyle(
                                color: Colors.white38
                            ),
                          ),
                          const SizedBox(width: 10,),
                      
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
