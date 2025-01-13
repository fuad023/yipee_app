import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/database_service.dart';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/appbar_action.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/submissions.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/search_user.dart';

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

  void setupHandle() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AppbarAction()));
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
          IconButton(
            onPressed: setupHandle,
            icon: const Icon(Icons.manage_accounts_outlined),
          ),
        ],
      ),
      body: _screens(_currentIndex),

      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _screens(int index) {
    return switch (_currentIndex) {
      0 => CfUserInfo(
        handle: handle!,
      ),
      1 => const Submissions(),
      2 => SearchUser(),
      
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
          icon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
      ],
    );
  }
}