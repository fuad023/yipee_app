import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/login_authentication/auth_services.dart';
import 'package:student_app/pages/auth/ui_components/my_textfield.dart';
import 'package:student_app/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String usenName;
  final String recieverID;
  ChatPage({
    super.key,
    required this.usenName,
    required this.recieverID
  });

  // Text controller
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();

  void sendMessage() async {
    // If controller is nor empty
    if(_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);

      // Clear text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usenName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authServices.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(recieverID, senderID),
      builder: (context, snapshot) {
        // Errors 
        if(snapshot.hasError) {
          return const Text('Error');
        }

        // Loading
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Return list
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Text(data["message"]);
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextfield(controller: _messageController, hintText: 'Type Text', obscureText: false),
        ),

        IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward)),
      ],
    );
  }
}