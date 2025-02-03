import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_pages/developer_handle/show_user_handle.dart';

class DeveloperHandle extends StatefulWidget {
  const DeveloperHandle({super.key});

  @override
  State<DeveloperHandle> createState() => _DeveloperHandleState();
}

class _DeveloperHandleState extends State<DeveloperHandle> {
  final AuthServices _authServices = AuthServices();
  final TextEditingController _emailController = TextEditingController();
  String devCode = '2533';
  String enteredPin = '';
  bool isVerified = false;
  bool creatingNewUser = false;

  void createAccount(BuildContext context) async {
    if(_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter Email!'),
          backgroundColor: Colors.red,
        )
      );
    } else {
      try {
        await _authServices.signUpWithEmailAndPassword(_emailController.text, '12345678');
        if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account Created!'),
              backgroundColor: Colors.green,
            )
          );
        }  
      } catch (e) {
        if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unable to create account!'),
              backgroundColor: Colors.red,
            )
          );
        }
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
        backgroundColor: Colors.black,
        body: isVerified ? devFeature() : verifyDeveloper(),
      ),
    );
  }

  Widget devFeature() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Developer Mode On',
          style: TextStyle(
            color: Colors.white70
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white70
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              creatingNewUser = !creatingNewUser;
            }),
            icon: creatingNewUser ? const Icon(Icons.done) : const Icon(Icons.add),
          )
        ],
      ),
      body: creatingNewUser ? developerCreatesNewUser() : const ShowUserHandle()
    );
  }

  Widget verifyDeveloper() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter Developer Key',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          PinCodeTextField(
            mainAxisAlignment: MainAxisAlignment.center,
            obscureText: true,
            obscuringCharacter: '#',
            appContext: context,
            length: 4,
            onChanged: (value) {
              setState(() {
                enteredPin = value;
              });
            },
            onCompleted: (value) {
              if (value == devCode) {
                setState(() {
                  isVerified = true;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid PIN. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40, // Reduced width of each box
              activeFillColor: Colors.white,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              fieldOuterPadding: const EdgeInsets.all(10),
            ),
            keyboardType: TextInputType.number,
            textStyle: const TextStyle(
              color: Colors.white70
            ),
          ),
        ],
      ),
    );
  }

  Widget developerCreatesNewUser() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter Email to Create an Account: ',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                label: const Text(
                  'Enter Email',
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.white
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.white
                  )
                )
              ),
              style: const TextStyle(
                color: Colors.white
              ),
              cursorColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20,),
          TextButton(
            onPressed: () => createAccount(context),
            child: const Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white
              ),
            )
          )
        ],
      ),
    );
  }
}