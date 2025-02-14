import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_api.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/api/codeforces_user.dart';

class UserDetails extends StatefulWidget {
  final String? handle;

  const UserDetails({
    super.key,
    required this.handle,
  });

  @override
  State<UserDetails> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserDetails> {
  String? _handle;
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
    _handle = widget.handle;
  }

  @override
  Widget build(BuildContext context) {
    return _handle == null ? _requestSetup() : _showUserInfo();
  }

  Widget _requestSetup() {
    return const Center(
      child: Text("Please setup handle name."),
    );
  }

  Widget _showUserInfo() {
    if (dataFetching) {
      _fetchUser(_handle!);
    }

    return dataFetching
    ? const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
      ),
    )
    : userInformation();
  }

  Widget userInformation() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 64.0,
                    backgroundImage: NetworkImage(_user.titlePhoto),
                  ),
                  const SizedBox(height: 16.0,),

                  Text(
                    _handle!,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 64.0,
                child: Divider(
                  color: Color(0xFFF7F7F7),
                  thickness: 3.0,
                ),
              ),
      
              _detailedInformation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailedInformation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textColumn([
          "Name",
          "Country",

          "Max Rank",
          "Rank",
          "Max Rating",
          "Rating",

          "Last seen",
          "Reg. on",
          "Friends",
        ], false),

        _textColumn([
          " : ${_user.getFirstName} ${_user.getLastName}",
          " : ${_user.getCountry}",

          " : ${_user.getMaxRank}",
          " : ${_user.getRank}",
          " : ${_user.getMaxRating}",
          " : ${_user.getRating}",

          " : ${_user.getLastOnlineTimeSeconds}",
          " : ${_user.getRegistrationTimeSeconds}",
          " : ${_user.getFriendOfCount}",
        ], true),
      ],
    );
  }

  Widget _textColumn(List<String> stream, bool isBold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: stream.map((text) => Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: isBold ? FontWeight.normal : FontWeight.w300,
          letterSpacing: isBold ? 1.0 : 0.0,
        ),
      )).toList(),
    );
  }
}