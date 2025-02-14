import 'package:flutter/material.dart';

class SingleText extends StatelessWidget {
  final String value;
  final bool bold;

  const SingleText({
    super.key,
    required this.value,
    required this.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontWeight: bold ? FontWeight.w500 : FontWeight.w300,
        fontSize: 11.0,
      ),
    );
  }
}

class DoubleText extends StatelessWidget {
  final String type;
  final String value;

  const DoubleText({
    super.key,
    required this.type,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          type,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 10.0
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.0
          ),
        ),
      ],
    );
  }
}