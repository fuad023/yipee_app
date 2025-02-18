import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/profile_module.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/user_details.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/chat_page.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/service/chat_service.dart';

import 'componenets/user_tile.dart';

class YipeePeople extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();
  YipeePeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Expanded(
          child: _buildUserList(),
        ),
      ],
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if (snapshot.hasError) {
          return const Text('Error');
        }

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Return list
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  // Extract the part before '@' and capitalize the first letter
  final String displayName = userData["email"].split('@').first;
  final String capitalizedDisplayName = displayName[0].toUpperCase() + displayName.substring(1).toLowerCase();
  final String uid = userData['uid'];

  if (userData["email"] != _authServices.getCurrentUser()!.email) {
    return UserTile(
      text: capitalizedDisplayName,
      onLongPress: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileModule(isMyProfile: false, uid: uid)));
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: capitalizedDisplayName,
              recieverID: userData["uid"],
            ),
          ),
        );
      },
    );
  } else {
    return Container();
  }
}


}
