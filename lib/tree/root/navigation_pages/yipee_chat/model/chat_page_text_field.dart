import 'package:flutter/material.dart';

class ChatPageTextField extends StatelessWidget {
  final TextEditingController controller;
  const ChatPageTextField({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
        maxHeight: 150,
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: null,
        cursorHeight: 25,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Messege',
          filled: true,
          fillColor: Colors.white70,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide.none
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          //isDense: true
        ),
      ),
    );
  }
}