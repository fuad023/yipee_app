import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/api/database_service.dart';

import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/appbar_action.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/cf_user_info.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/submissions.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/navigation_pages/contest_list.dart';

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
      ),
      body: _screens(_currentIndex),
      drawerEnableOpenDragGesture: true,
      endDrawer: _myDrawer(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _screens(int index) {
    return switch (_currentIndex) {
      0 => CfUserInfo(
        handle: handle!,
      ),
      1 => Submissions(
        handle: handle!,
      ),
      2 => const ContestList(),
      
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
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Contest List',
        ),
      ],
    );
  }

  Widget _myDrawer() {
    return Drawer(
      child: Container(
        color: Colors.green,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.white,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child:  Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.manage_accounts_outlined, color: Colors.white,),
                    title: _myText("Change Handle"),
                    onTap: setupHandle,
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_search_rounded, color: Colors.white,),
                    title: _myText("Search Profile"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined, color: Colors.white,),
                    title: _myText("Contest List"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ] 
        ),
      ),
    );
  }

  Widget _myText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        // letterSpacing: 2.0,
      ),
    );
  }
}