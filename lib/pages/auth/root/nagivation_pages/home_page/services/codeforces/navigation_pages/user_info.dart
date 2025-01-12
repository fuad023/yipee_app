import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/ui_components/my_button.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/cf_user_info.dart';

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
  final CodeforcesApi _codeforcesApi = CfGetUserInfo();
  late CodeforcesUserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    handle = widget.handle;
  }

  void getUserInfo(String handleId) async {
    await _codeforcesApi.setUserInfo(handleId);
    handle = _codeforcesApi.getUserInfo().handle;
    _userInfo = _codeforcesApi.getUserInfo();
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return handle == null ? _requestSetup() : _showUserInfo();
  }

  Widget _requestSetup() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Set up handle here",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                letterSpacing: 1.5,
              )
            ),
        
            const SizedBox(height: 15.0),
        
            MyTextfield(
              controller: _handlerName,
              hintText: "handle name",
              obscureText: false
            ),
        
            const SizedBox(height: 15.0),
        
            MyButton(
              text: "Set Handle",
              onTap: () => getUserInfo(_handlerName.text),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showUserInfo() {
    return Container(
      padding: const EdgeInsets.only(bottom: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              
              children: [
                CircleAvatar(
                  radius: 64.0,
                  backgroundImage: NetworkImage(_userInfo.titlePhoto),
                ),
                const SizedBox(height: 16.0,),
          
                Text(
                  _userInfo.handle,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48.0,),
    
          Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textfield("Name: ", "${_userInfo.firstName} ${_userInfo.lastName}"),
                  _textfield("Country: ", "${_userInfo.country}"),

                  _textfield("Max Rank: ", "${_userInfo.maxRank}"),
                  _textfield("Rank: ", "${_userInfo.rank}"),
                  _textfield("Max Rating: ", "${_userInfo.maxRating}"),
                  _textfield("Rating: ", "${_userInfo.rating}"),
                  
                  _textfield("Last seen: ", _userInfo.lastOnlineTimeSeconds),
                  _textfield("Reegistered on: ", _userInfo.registrationTimeSeconds),
                  _textfield("Friends: ", _userInfo.friendOfCount),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textfield(String text, String key) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
          ),
        ),
        Text(
          key,
          style: const TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black,
            fontSize: 16.0,
            // fontWeight: FontWeight.w300,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}