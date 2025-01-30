import 'package:flutter/material.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';

class PublicUserDetails extends StatefulWidget {
  final String handle;

  const PublicUserDetails({
    super.key,
    required this.handle,
  });

  @override
  State<PublicUserDetails> createState() => _UserInfoState();
}

class _UserInfoState extends State<PublicUserDetails> {
  late String _handle;
  bool dataFetching = true;
  final CodeforcesApi _codeforcesApi = CodeforcesUser();
  late ResultUser _user;

  void _fetchUser(String handle) async {
    try {
      _user = (await _codeforcesApi.fetchUser(handle))!;
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
    _handle = widget.handle;
    return _handle.isEmpty ? _requestSetup() : _showUserInfo();
  }

  Widget _requestSetup() {
    return const Center(
      child: Text("Please setup handle name."),
    );
  }

  Widget _showUserInfo() {
    if (dataFetching) {
      _fetchUser(_handle);
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
                  backgroundImage: NetworkImage(_user.titlePhoto),
                ),
                const SizedBox(height: 16.0,),
          
                Text(
                  _handle,
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
                  _textfield("Name: ", "${_user.getFirstName} ${_user.getLastName}"),
                  _textfield("Country: ", _user.getCountry),

                  _textfield("Max Rank: ", _user.getMaxRank),
                  _textfield("Rank: ", _user.getRank),
                  _textfield("Max Rating: ", _user.getMaxRating),
                  _textfield("Rating: ", _user.getRating),
                  
                  _textfield("Last seen: ", _user.getLastOnlineTimeSeconds),
                  _textfield("Reegistered on: ", _user.getRegistrationTimeSeconds),
                  _textfield("Friends: ", _user.getFriendOfCount),
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