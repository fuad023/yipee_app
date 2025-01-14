import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/cf_user_info.dart';

class CfUserInfo extends StatefulWidget {
  final String handle;

  const CfUserInfo({
    super.key,
    required this.handle,
  });

  @override
  State<CfUserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<CfUserInfo> {
  late String handle;
  bool dataFetching = true;
  final CodeforcesApi _codeforcesApi = CfGetUserInfo();
  late CodeforcesUserInfo _userInfo;

  void getUserInfo(String handleId) async {
    try {
      await _codeforcesApi.setUserInfo(handleId);
      handle = _codeforcesApi.getUserInfo().handle;
      _userInfo = _codeforcesApi.getUserInfo();
      if (!mounted) return;
      
      setState(() {
          dataFetching = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          dataFetching = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    handle = widget.handle;
    return handle.isEmpty ? _requestSetup() : _showUserInfo();
  }

  Widget _requestSetup() {
    return const Center(
      child: Text("Please setup handle name."),
    );
  }

  Widget _showUserInfo() {
    if (dataFetching) {
      getUserInfo(handle);
    }

    return dataFetching
    ? Center(
      child: CircularProgressIndicator(
        color: Colors.green[700],
      ),
    )
    : Container(
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
            padding: const EdgeInsets.only(left: 32.0),
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