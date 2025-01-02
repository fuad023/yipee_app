import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 200.0,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/katz.jpg'),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      ' K A T Z ',
                      style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'katz@email.com',
                      style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
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
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
  }
}