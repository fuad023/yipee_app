import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/database_codeforces.dart';

import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/drawer/my_drawer.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/user_details.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/submissions.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/user_rating_history.dart';

class Codeforces extends StatefulWidget {
  const Codeforces({super.key});

  @override
  State<Codeforces> createState() => _CodeforcesState();
}

class _CodeforcesState extends State<Codeforces> {
  int _currentIndex = 0;
  String? handle;
  bool isFetched = false;

  void fetchHandle() async {      
    DatabaseCodeforces database = DatabaseCodeforces();
    handle = await database.fetchHandle();
    isFetched = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchHandle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text("Codeforces"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
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
    return !isFetched 
    ? Center(
      child: CircularProgressIndicator(
        color: Colors.green[700],
      ),
    )
    : switch (_currentIndex) {
      0 => UserDetails(handle: handle),
      1 => Submissions(handle: handle),
      2 => UserRatingHistory(handle: handle),
      
      int() => throw UnimplementedError(),
    };
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      elevation: 1.0,
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