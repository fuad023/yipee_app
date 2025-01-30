import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/root/navigation_pages/yipee_chat/chat_page.dart';
import 'package:student_app/pages/auth/root/navigation_pages/yipee_chat/service/chat_service.dart';

import 'componenets/user_tile.dart';

class YipeePeople extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();
  YipeePeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SafeArea(
          child: Center(
            child: Text(
              'Chat List',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Opacity(
                opacity: 0.5,
                child: SizedBox(
                  width: 300.0,
                  child: Divider(
                    height: 10.0,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
        Expanded(
          // Ensures the ListView takes up remaining space
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

  if (userData["email"] != _authServices.getCurrentUser()!.email) {
    return UserTile(
      text: capitalizedDisplayName, // Use the capitalized display name
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: capitalizedDisplayName, // Pass the capitalized display name
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
