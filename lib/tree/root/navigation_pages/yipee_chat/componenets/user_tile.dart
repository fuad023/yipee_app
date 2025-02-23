import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final Function()? onLongPress;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.onLongPress
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0.5, 0, 0),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0x44FFFFFF),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.person_3_rounded),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}