import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/home_page.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/yipee_people.dart';
import 'package:student_app/tree/root/navigation_pages/emergency.dart';
import 'package:student_app/tree/root/drawer_section/drawer_screen.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<String> screenNames = [
    'Yipee App', 'Chat List', ''
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email??'No Email';
    final String userName = userEmail.split('@').first;
    final List<Widget> screens = [
      HomePage(userName: userName,),
      YipeePeople(),
      const EmergencyPage(),
    ];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
          title: Text(
            screenNames[_currentIndex],
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        drawer: DrawerScreen(email: userEmail),
        body: SafeArea(child: screens[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
          iconSize: 30,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.textsms_outlined),
              activeIcon: Icon(Icons.textsms_rounded),
              label: 'YipeeChat',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.emergency),
              icon: Icon(Icons.emergency_outlined),
              label: 'Emergency',
            ),
          ],
        ),
      ),
    );
  }
}
