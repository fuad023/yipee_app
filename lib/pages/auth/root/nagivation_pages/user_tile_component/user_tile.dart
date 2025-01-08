import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Row(
          children: [
            Icon(Icons.person_2),
            SizedBox(width: 5,),
            Text(text),
          ],
        ),
      ),
    );
  }
}