import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friendService.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friend_model.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/profile_section/profile_module.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/stream_section/stream_builder.dart';

class StreamDisplayer extends StatelessWidget {
  final FriendStreamBuild _friendStreamBuild = FriendStreamBuild();
  final FriendService _friendService = FriendService();
  final String uid;
  final String collectionType;
  StreamDisplayer({
    super.key,
    required this.uid,
    required this.collectionType
  });

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: _friendStreamBuild.getUserList(uid, collectionType), 
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading friends"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No friends available"));  
        }

        List<FriendModel> friendList = snapshot.data!;

        return ListView.builder(
          itemCount: friendList.length,
          itemBuilder: (context, index) => _buildFriendTile(context, friendList[index])
        );
      },
    );
  }

  Widget _buildFriendTile(BuildContext context, FriendModel friends) {
    final bool isCurrentUser = uid == FirebaseAuth.instance.currentUser!.uid;
    final bool isCurrentUserProfile = friends.friendId == FirebaseAuth.instance.currentUser!.uid;
    DateTime dateTime = friends.timeStamp.toDate();
    String formattedDate = DateFormat('EEEE, MMM d, yyyy').format(dateTime);
    return Column(
      children: [
        ListTile(
          onTap:  () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileModule(
              isMyProfile: isCurrentUserProfile ? true : false, 
              uid: friends.friendId
            )));
          },
          title: Text(
            friends.friendName
          ),
          leading: const Icon(
            Icons.person
          ),
          trailing: PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            elevation: 4,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Center(
                  child: isCurrentUserProfile
                  ? Text(
                    'Friends since  $formattedDate'
                  )
                  : Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          isCurrentUser
                          ? _friendService.cancleRequest(friends.friendId, friends.uid, true)
                          : _friendService.sendRequest(friends.friendId);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                             isCurrentUser ? Icons.person_remove : Icons.person_add
                            ),
                            const SizedBox(width: 15),
                            Text(
                              isCurrentUser ? 'Unfriend' : 'Add Friend')
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black12,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.message),
                          SizedBox(width: 15),
                          Text('Message')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
            child: const Icon(Icons.more_horiz),
          ),
          tileColor: Colors.white,
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}