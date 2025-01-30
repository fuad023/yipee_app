import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/root/drawer_section/account_page.dart';

class DrawerScreen extends StatelessWidget {
  final String email;

  const DrawerScreen({
    super.key,
    required this.email,
  });

  void logout() {
    final firebaseAuth = AuthServices();
    firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 215.0,
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/katz.jpg'),
                  ),
                  const SizedBox(height: 10.0,),
                  const Text(
                    ' K A T Z ',
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) => const AccountManagePage())
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}