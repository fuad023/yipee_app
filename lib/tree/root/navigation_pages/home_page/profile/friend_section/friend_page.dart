import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/stream_section/stream_displayer.dart';

class FriendPage extends StatelessWidget {
  final String userId;
  final String uid;
  const FriendPage({
    super.key,
    required this.userId,
    required this.uid
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
          title: Text(
            userId
          ),
        ),
        body: Column(
          children: [
            const TabBar(
              indicatorColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  icon: Icon(Icons.people),
                  text: 'Friends',
                ),
                Tab(
                  icon: Icon(Icons.person_add_alt_1),
                  text: 'Requests',
                ),
                Tab(
                  icon: Icon(Icons.person_pin),
                  text: 'Add Friend',
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  StreamDisplayer(uid: uid, collectionType: 'friends',),
                  StreamDisplayer(uid: uid, collectionType: 'recieved'),
                  const Center(child: Text('No Friend Requests'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}