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

  

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? 'No email';
    final String userName = user?.email?.split('@').first ?? 'No username';
    final List<Widget> _screens = [
    HomePage(userName: userName,),
    MessagePage(),
    const EmergencyPage(),
  ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        drawer: DrawerScreen(email: userName),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(18.0),
        ),
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
        // Wrap the Scaffold in a Builder widget to ensure we can access the context correctly
        // floatingActionButton: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.dehaze),
        //       color: Colors.white,
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer(); // Open the drawer
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
