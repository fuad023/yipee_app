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
  bool _isImageLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isImageLoaded) {
      _preloadBackgroundImage();
    }
  }

  Future<void> _preloadBackgroundImage() async {
    try {
      await precacheImage(const AssetImage('assets/home_bg.png'), context);
      setState(() {
        _isImageLoaded = true;
      });
    } catch (e) {
      debugPrint("Error loading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isImageLoaded) {
      return Scaffold(
        backgroundColor: Color(0xFF2B5F56),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.015,
              ),
              const Text(
                'A moment please...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final User? user = FirebaseAuth.instance.currentUser;
    final String userName = user?.email?.split('@').first ?? 'No username';
    final List<Widget> screens = [
      HomePage(
        userName: userName,
      ),
      MessagePage(),
      const EmergencyPage(),
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: DrawerScreen(email: userName),
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, 0.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/home_bg.png',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.0, 0.0),
                ),
              ),
            ),
            Positioned(
              top: 20,
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
            Align(
              alignment: Alignment.center,
              child: screens[_currentIndex],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 9, 88, 39),
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
      ),
    );
  }
}
