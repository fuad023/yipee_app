import 'package:flutter/material.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/search_user/public/public_user_details.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/search_user/public/public_submissions.dart';
import 'package:student_app/pages/root/navigation_pages/home_page/services/codeforces/drawer/search_user/public/public_user_rating_history.dart';

class Public extends StatefulWidget {
  final String handle;

  const Public({
    super.key,
    required this.handle,
  });

  @override
  State<Public> createState() => _CodeforcesState();
}

class _CodeforcesState extends State<Public> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text(widget.handle),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green[700],
        elevation: 1.0,
      ),
      body: _screens(_currentIndex),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _screens(int index) {
    return switch (_currentIndex) {
      0 => PublicUserDetails(handle: widget.handle),
      1 => PublicSubmissions(handle: widget.handle),
      2 => PublicUserRatingHistory(handle: widget.handle),
      
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