import 'package:flutter/material.dart';
import 'package:student_app/tree/root/drawer_section/settings/account_management/account_management_ui.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade200,
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountManagementUi())),
              leading: const Icon(
                Icons.lock_person_outlined,
              ),
              title: const Text(
                'Account Mannage',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Delete account . Reset password',
                style: TextStyle(color: Color.fromARGB(210, 0, 0, 0)),
              ),
              tileColor: const Color.fromARGB(47, 241, 233, 233),
            )
          ],
        )
      );
  }
}
