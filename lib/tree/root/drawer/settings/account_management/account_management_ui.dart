import 'package:flutter/material.dart';
import 'package:student_app/tree/root/drawer/settings/account_management/account_actions.dart';

class AccountManagementUi extends StatelessWidget {

  const AccountManagementUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Account Manngement',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: ListView(
          children: [
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountActions(buildState: 'password',))),
              leading: const Icon(
                Icons.restore,
              ),
              title: const Text(
                'Reset Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: const Color.fromARGB(47, 241, 233, 233),
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountActions(buildState: '',))),
              leading: const Icon(
                Icons.mark_email_unread_outlined,
              ),
              title: const Text(
                'Change Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: const Color.fromARGB(47, 241, 233, 233),
            ),
            const SizedBox(height: 10,),
            ListTile(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountActions(buildState: 'delete',))),
              leading: const Icon(
                Icons.remove_circle_outline,
              ),
              title: const Text(
                'Delete Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: const Color.fromARGB(47, 241, 233, 233),
            ),
          ],
        ),
    );
  }
}