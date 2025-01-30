import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:student_app/tree/auth_service/login_pages/show_user_handle.dart';

class DeveloperHandle extends StatefulWidget {
  const DeveloperHandle({super.key});

  @override
  State<DeveloperHandle> createState() => _DeveloperHandleState();
}

class _DeveloperHandleState extends State<DeveloperHandle> {
  String devCode = '1234';
  String enteredPin = '';
  bool isVerified = false;

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
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white70
        )
      ),
      body: const ShowUserHandle(),
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
}