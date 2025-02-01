import 'package:flutter/material.dart';
// import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/drawer/change_handle.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/drawer/contest_list.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/drawer/search_user/search_user.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // void _chageRouteSetupHandle(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeHandle()));
  // }

  void _changeRouteSearchUser(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchUser()));
  }

  void _chageRouteContestList(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContestList()));
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
                  // ListTile(
                  //   leading: const Icon(Icons.manage_accounts_outlined, color: Colors.white,),
                  //   title: _myText("Change Handle"),
                  //   onTap: () => _chageRouteSetupHandle(context),
                  // ),
                  ListTile(
                    leading: const Icon(Icons.person_search_rounded, color: Colors.white,),
                    title: _myText("Search User"),
                    onTap: () => _changeRouteSearchUser(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined, color: Colors.white,),
                    title: _myText("Contest List"),
                    onTap: () => _chageRouteContestList(context),
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