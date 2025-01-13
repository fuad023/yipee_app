import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/home.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/message.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/emergency.dart';
import 'package:student_app/pages/auth/root/drawer_screen.dart';

class RootPage extends StatefulWidget {
  
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    MessagePage(),
    const EmergencyPage(),
  ];

  @override
  Widget build(BuildContext context) {
  final User? user = FirebaseAuth.instance.currentUser;
  final String userName = user?.email ?? 'No email';

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text('YipeeApp'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
      ),
      body: _screens[_currentIndex],

      drawer: DrawerScreen(email: userName,),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.textsms_rounded),
            label: 'YipeeChat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: 'Emergency',
          ),
        ],
      ),
    );
  }
}