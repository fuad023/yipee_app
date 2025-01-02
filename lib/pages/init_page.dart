import 'package:flutter/material.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  void wait() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/loading');
  }

  @override
  void initState() {
    super.initState();
    wait();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Root Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}