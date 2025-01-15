import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/drawer/my_drawer.dart';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/database_service.dart';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/user_details.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/submissions.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/user_rating_history.dart';

class Codeforces extends StatefulWidget {
  final String handle;

  const Codeforces({
    super.key,
    required this.handle,
  });

  @override
  State<Codeforces> createState() => _CodeforcesState();
}

class _CodeforcesState extends State<Codeforces> {
  int _currentIndex = 0;
  String? handle;

  void fetchHandle() async {
    if (handle == "") {
      
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      DatabaseService database = DatabaseService();
      String uid = firebaseAuth.currentUser!.uid;
      handle = await database.fetchHandle(uid);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    handle = widget.handle;
    fetchHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: const Text("Codeforces"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
        actions: [
          Builder(
            builder:(BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }
          ),
        ],
      ),
      body: _screens(_currentIndex),
      drawerEnableOpenDragGesture: true,
      endDrawer: const MyDrawer(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _screens(int index) {
    return switch (_currentIndex) {
      0 => UserDetails(handle: handle!),
      1 => Submissions(handle: handle!),
      2 => UserRatingHistory(handle: handle!),
      
      int() => throw UnimplementedError(),
    };
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
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
          icon: Icon(Icons.perm_identity),
          label: 'User Info',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.code_rounded),
          label: 'Submissions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_rounded),
          label: 'Rating History',
        ),
      ],
    );
  }
}