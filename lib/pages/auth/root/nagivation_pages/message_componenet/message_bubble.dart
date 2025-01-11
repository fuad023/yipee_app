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
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green : Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      child: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
