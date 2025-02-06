import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/home_page.dart';
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

  final List<String> screenNames = [
    '', 'Chat List', ''
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
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            screenNames[_currentIndex],
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white
          ),
        ),
        drawer: DrawerScreen(email: userEmail),
        body: Stack(
          children: [
            Align(
              //alignment: const Alignment(0.0, 0.0),
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
            SafeArea(child: screens[_currentIndex]),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.white70,
          unselectedFontSize: 15,
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedIconTheme: const IconThemeData(size: 35),
          selectedFontSize: 20,
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
