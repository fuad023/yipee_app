import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/drawer/change_handle.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void setupHandle(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeHandle()));
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: () => setupHandle(context),
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