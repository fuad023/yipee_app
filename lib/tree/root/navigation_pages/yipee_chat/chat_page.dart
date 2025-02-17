import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/componenets/message_bubble.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/model/chat_page_text_field.dart';
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
      Future.delayed(const Duration(milliseconds: 0), () => scrollDown());
    });

    // Add listener to scroll down when the text field is focused
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 0), () => scrollDown());
      }
    });
  }

  String formateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1D3531),
        appBar: AppBar(
          title: Text(widget.userName),
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
          backgroundColor: const Color(0xFF1A4C36),
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            Container(
              constraints: const BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: 200
              ),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 16, 29, 27)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ChatPageTextField(controller: _messageController,),
                  IconButton(
                    onPressed: () => sendMessage(),
                    icon: const Icon(Icons.send,
                      size: 35,
                      color: Colors.white70,
                    )
                  )
                ],
              ),
            ),
          ],
        ),
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

        List<DocumentSnapshot> messages = snapshot.data!.docs;

        return ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return _buildMessageListItem(messages, index);
          },
        );
      },
    );
  }

  Widget _buildMessageListItem(List<DocumentSnapshot> messages, int index) {
  Map<String, dynamic> data = messages[index].data() as Map<String, dynamic>;
  bool isCurrentUser = data["senderID"] == _authServices.getCurrentUser()?.uid;
  Timestamp currentTimestamp = data["timestamp"];


  bool showTime = true;

  if (index > 0) {
    Map<String, dynamic> previousData = messages[index - 1].data() as Map<String, dynamic>;
    Timestamp? previousTimestamp = previousData["timestamp"];

    if (previousTimestamp != null) {
      Duration difference = currentTimestamp.toDate().difference(previousTimestamp.toDate());
      if (difference.inMinutes < 3) {
        showTime = false;
      }
    }
  }
    return Column(
      children: [
        if(showTime) const SizedBox(height: 10,),
        if(showTime) 
        Text(
          formateTime(currentTimestamp),
          style: const TextStyle(
            color: Colors.white
          ),
        ),
        Align(
          alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: MessageBubble(isCurrentUser: isCurrentUser, message: data["message"]),
        ),
      ],
    );
  }

  Widget buildUserInput() {
    return const Row(
      children: [
        TextField()
      ],
    );
  }
}