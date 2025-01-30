import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/componenets/message_bubble.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/componenets/message_textfield.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/service/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String recieverID;

  const ChatPage({super.key, required this.userName, required this.recieverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthServices _authServices = AuthServices();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Scroll to the bottom when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
    });

    // Add listener to scroll down when the text field is focused
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _chatService.sendMessage(widget.recieverID, _messageController.text);
      _messageController.clear();
      scrollDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
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
    String? senderID = _authServices.getCurrentUser()?.uid;
    if (senderID == null) {
      return const Center(child: Text("User not logged in."));
    }

    return StreamBuilder(
      stream: _chatService.getMessage(widget.recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading messages"));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("No messages yet."));
        }

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((doc) => _buildMessageListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data["senderID"] == _authServices.getCurrentUser()?.uid;
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: MessageBubble(isCurrentUser: isCurrentUser, message: data["message"]),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 20),
            child: MessageTextfield(
              controller: _messageController,
              hintText: 'Type Text',
              obscureText: false,
              focusNode: _focusNode,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward),
            ),
          ),
        ),
      ],
    );
  }
}
