import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/user_info.dart';

class Codeforces extends StatefulWidget {

  const Codeforces({super.key});

  @override
  State<Codeforces> createState() => _CodeforcesState();
}

class _CodeforcesState extends State<Codeforces> {
  final TextEditingController _handlerName = TextEditingController();
  late CodeforcesApi _codeforcesApi;
  CfUserInfo? _cfUserInfo;

  void searchUser(BuildContext context) async {
    String handle = _handlerName.text;
    _handlerName.clear();
    _codeforcesApi = CfGetUserInfo(handle: handle);
    _cfUserInfo = await _codeforcesApi.getUserInfo();
    
    if (_cfUserInfo != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(cfUserInfo: _cfUserInfo,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Codeforces"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
      ),
      body: _searchUser(),
    );
  }

  Widget _searchUser() {
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
            text: "Search",
            onTap: () => searchUser(context),
          ),
        ],
      ),
    );
  }
}