import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/chat_page.dart';
import 'package:student_app/services/chat/chat_service.dart';

import 'message_componenet/user_tile.dart';

class MessagePage extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();
  MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildUserList(),
      ),
    );
  }


  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // Error
        if(snapshot.hasError) {
          return const Text('Error');
        }

        // Loading
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Return list
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData["email"] != _authServices.getCurrentUser()!.email) {
      return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(
            userName: userData["email"],
            recieverID: userData["uid"],
          ))
        );
      }
    );
    } else {
      return Container();
    }
  }

}