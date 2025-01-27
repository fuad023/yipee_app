import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/drawer/delete_acc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          ListTile(
            leading: const Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 30.0,
            ),
            title: const Text(
              'Delete Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            tileColor: const Color.fromARGB(148, 158, 158, 158),
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfirmPassword()));
            },
          ),
        ],
      ),
    );
  }

}
