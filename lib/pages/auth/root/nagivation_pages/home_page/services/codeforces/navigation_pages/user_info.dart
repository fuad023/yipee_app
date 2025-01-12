import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';

class UserInfo extends StatefulWidget {
  final String? handle;

  const UserInfo({
    super.key,
    required this.handle,
  });

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String? handle;
  final TextEditingController _handlerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    handle = widget.handle;
  }

  // void getUserInfo(String handle) async {
  //   _codeforcesApi = CfGetUserInfo(handle: handle);
  // }
  
  @override
  Widget build(BuildContext context) {
    return handle == null ? _requestSetup() : _userInfo();
  }

  Widget _requestSetup() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyTextfield(
            controller: _handlerName,
            hintText: "Handler name",
            obscureText: false
          ),

          const SizedBox(height: 15.0),

          MyButton(
            text: "Set Handle",
            onTap: () {} // => getUserInfo(_handlerName.text),
          ),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return const Center(
      child: Text("Setup complete!"),
    );
  }
}