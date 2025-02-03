import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_get.dart';
import 'package:student_app/tree/root/drawer/settings/account_mannagement/remastared_text_field.dart';
import 'package:student_app/tree/root/drawer/settings/account_mannagement/user_service.dart';

class VerifyUser extends StatefulWidget {
  final String buildState; // Upon this Change email or password will show
  const VerifyUser({
    super.key,
    required this.buildState,
  });

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final UserService _userService = UserService();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _confirmationController = TextEditingController();
  bool isVerifiedUser = false;
  
  void userVerification(BuildContext context) async {
    if(_passwordController.text.isNotEmpty) {
      try{
        final userEmail = _userService.getCurrentUserEmail();
        await _userService.verifyUser(userEmail, _passwordController.text);
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verified Successfully!'),
          backgroundColor: Colors.green,
        )
      );
      setState(() {
        isVerifiedUser = true;
        _passwordController.clear();
      });
        }
      } catch (e) {
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to verify!'),
          backgroundColor: Colors.red,
        )
      );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter password'),
          backgroundColor: Colors.red,
        )
      );
    }
  }

  void resetPassword(BuildContext context) async {
    if(_passwordController.text.isEmpty) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a New Password!'),
            backgroundColor: Colors.red,
          )
        );
      }
    } else if (_passwordController.text != _confirmPasswordController.text) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password doesn\'t match!'),
            backgroundColor: Colors.red,
          )
        );
      }
    } else {
      try {
        await _userService.updatePassword(_passwordController.text);
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset successfully!'),
            backgroundColor: Colors.green,
          )
        );
        Navigator.pop(context);
      }
      } catch (e) {
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Couldn\'t reset password!'),
            backgroundColor: Colors.red,
          )
        );
      }
      }  
    }
  }  

  void deleteUserAccount(BuildContext context) async {
    try {
      await _userService.deleteAccount();
      if(context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthGet()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account Deleted!'),
            backgroundColor: Colors.red,
          )
        );
      }
    } catch (e) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Couldn\'t delete account!'),
            backgroundColor: Colors.red,
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.green.shade200,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Account Mannagement',
            style: TextStyle(       
              color: Colors.white
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
        ),
        body: !isVerifiedUser ? verifyUsers() : widget.buildState == 'password' ? changePassword() : widget.buildState == 'delete' ? deleteUser() : Container()
      ),
    );
  }

  Widget verifyUsers() {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter password for verfication: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20,),
              ActiveTextfield(
                labelText: 'Password',
                isobsecureText: true,
                controller: _passwordController,
                prefixIconForOtherInput: false,
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextButton(
                  onPressed: () => userVerification(context),
                  child: const Text(
                    'Confirm password',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              )
            ],
          ),
        );
  }

  Widget changePassword() {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter New Password: '
              ),
              const SizedBox(height: 20,),
              ActiveTextfield(
                labelText: 'New Password',
                isobsecureText: true,
                controller: _passwordController,
                prefixIconForOtherInput: false,
              ),
              const SizedBox(height: 20,),
              ActiveTextfield(
                labelText: 'Confirm Password',
                isobsecureText: true,
                controller: _confirmPasswordController,
                prefixIconForOtherInput: false,
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextButton(
                  onPressed: () => resetPassword(context),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              )
            ],
          ),
        );
  }

  Widget deleteUser() {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Write ',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  Text(
                    'CONFIRM ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  Text(
                    'to continiue: ',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              ActiveTextfield(
                labelText: '',
                isobsecureText: false,
                controller: _confirmationController,
                prefixIconForOtherInput: true
              ),
              const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextButton(
                  onPressed: () {
                    if(_confirmationController.text == 'CONFIRM') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Sure want to delete your account'),
                          actions: [
                            TextButton(onPressed: () {
                              deleteUserAccount(context);
                            }, child: const Text('Yes')),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: const Text('No'))
                          ],
                        )
                      );
                    } else {
                        if(context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                            content: Text('Invalid!'),
                            backgroundColor: Colors.red,
                          )
                        );
                      }
                  }
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              )
            ],
          ),
        );
  }
}