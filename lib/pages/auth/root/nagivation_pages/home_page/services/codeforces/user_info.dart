import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/api/cf_user_info.dart';

class UserInfo extends StatelessWidget {
  final CfUserInfo? cfUserInfo;

  const UserInfo({
    super.key,
    required this.cfUserInfo,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.green[100],
        padding: const EdgeInsets.only(bottom: 256.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                
                children: [
                  CircleAvatar(
                    radius: 64.0,
                    backgroundImage: NetworkImage(cfUserInfo!.titlePhoto),
                  ),
                  const SizedBox(height: 16.0,),
            
                  Text(
                    cfUserInfo!.handle,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0,),

            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textfield("Last seen: ${cfUserInfo!.lastOnlineTimeSeconds}"),
                    _textfield("Reegistered on: ${cfUserInfo!.registrationTimeSeconds}"),
                    _textfield("Friends: ${cfUserInfo!.friendOfCount}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textfield(String text) {
    return Text(
      text,
      style: const TextStyle(
        decoration: TextDecoration.none,
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w200,
        letterSpacing: 1.0,
      ),
    );
  }
}
