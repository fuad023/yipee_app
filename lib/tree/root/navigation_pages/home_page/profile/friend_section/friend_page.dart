import 'package:flutter/material.dart';

class FriendPage extends StatelessWidget {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
          title: const Text(
            '@userId'
          ),
        ),
        body: const Column(
          children: [
            TabBar(
              indicatorColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  icon: Icon(Icons.people),
                ),
                Tab(
                  icon: Icon(Icons.person_add_alt_1),
                ),
                Tab(
                  icon: Icon(Icons.how_to_reg),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}