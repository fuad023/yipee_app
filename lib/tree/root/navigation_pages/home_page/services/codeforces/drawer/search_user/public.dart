import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/user_details.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/submissions.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/navigation_pages/user_rating_history.dart';

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
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: Text(widget.handle),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        elevation: 1.0,
      ),
      body: _screens(_currentIndex),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _screens(int index) {
    return switch (_currentIndex) {
      0 => UserDetails(handle: widget.handle),
      1 => Submissions(handle: widget.handle),
      2 => UserRatingHistory(handle: widget.handle),
      
      int() => throw UnimplementedError(),
    };
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
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