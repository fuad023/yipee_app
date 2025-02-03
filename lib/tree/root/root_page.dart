import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/home.dart';
import 'package:student_app/tree/root/navigation_pages/yipee_chat/yipee_people.dart';
import 'package:student_app/tree/root/navigation_pages/emergency.dart';
import 'package:student_app/tree/root/drawer/drawer_screen.dart';

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
    final String userName = user?.email?.split('@').first ?? 'No username';
    final String userEmail = user?.email ?? 'No Email';
    final List<Widget> screens = [
      HomePage(
        userName: userName,
      ),
      YipeePeople(),
      const EmergencyPage(),
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: DrawerScreen(email: userEmail),
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, 0.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/home_bg1.png',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.0, 0.0),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 1,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.dehaze, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            Center(child: screens[_currentIndex]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 215, 224, 216),
          selectedItemColor: Colors.green,
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
      ),
    );
  }
}
