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
    return Center(
      child: Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _profile(),
              const SizedBox(
                child: Divider(
                  color: Color(0xFFF7F7F7),
                  thickness: 3.0,
                ),
              ),

              _profileDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 32.0,),
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
    );
  }

  Widget _profileDetails() {
    return Container(
      // color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
      ),
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