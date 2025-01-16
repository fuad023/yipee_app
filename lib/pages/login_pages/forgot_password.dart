import 'package:flutter/material.dart';
import 'package:student_app/components/login_textField.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final AuthServices authServices = AuthServices();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).unfocus(); // Removes focus
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
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

    try {
      await authServices.resetPassword(_emailController.text);
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Success'),
          content: Text('A password reset email has been sent'),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
        ),
      );
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
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF1F4F8),
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, -1.64),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  'assets/1.png',
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.0, 0.0),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: const Alignment(1.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      MediaQuery.of(context).size.width * 0.15,
                      MediaQuery.of(context).size.width * 0.1,
                      0.0,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.clear_outlined,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: const Alignment(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment(-1, -1),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.16,
                        top: MediaQuery.of(context).size.height * 0.15,
                      ),
                      child: const Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: const Alignment(0.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: LoginTextField(
                            controlText: _emailController,
                            secureText: false,
                            hitText: 'Enter Email',
                            focusNode: _focusNode,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, -1.0),
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1,),
                      child: Container(
                        width: 331.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          onPressed: () {
                            resetPassword();
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
                  ),
                  const Align(
                    alignment: Alignment(0.0, -1.0),
                    child: Icon(
                      Icons.lock_rounded,
                      color: Color(0xFF2B5F56),
                      size: 70.0,
                    ),
                  ),
                  const Text(
                    'Forgot',
                    style: TextStyle(
                      color: Color(0xFF2B5F56),
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'Password?',
                    style: TextStyle(
                      color: Color(0xFF2B5F56),
                      fontSize: 40.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 100),
                    child: Text(
                      'No worries, we\'ll send you\n reset instruction',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2B5F56),
                        fontSize: 14.0,
                      ),
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
