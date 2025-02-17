import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isCurrentUser;
  final String message;
  const MessageBubble({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: isCurrentUser ? const Color.fromARGB(255, 59, 177, 126) : const Color(0xFF1A4C36),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: SelectableText(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18
        ),
      ),
    );
  }
}
