import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';
import 'package:student_app/tree/root/drawer_section/manage_account/account_page.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friendService.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friend_model.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friend_page.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/profile_section/profile_details.dart';

class ProfileModule extends StatefulWidget {
  final bool isMyProfile;
  final String uid;
  const ProfileModule({
    super.key, 
    required this.isMyProfile,
    required this.uid
  });

  @override
  State<ProfileModule> createState() => _ProfileModuleState();
}

class _ProfileModuleState extends State<ProfileModule> {
  final AuthServices _authServices = AuthServices();
  final FriendService _friendService = FriendService();
  bool isDataFetching = true;
  bool accessingRequest = false;
  bool showResponseButton = false;
  late String requestButton;
  late UserCredentials usercredentials;
  late FriendModel? friendModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String uid = widget.isMyProfile ? _authServices.getCurrentUserUID() ?? '0' : widget.uid;
    usercredentials = await _authServices.userInformation(uid);
    if(!widget.isMyProfile) {
      friendModel = await _friendService.getFriendInformation(uid);
      if(friendModel != null) {
      if(friendModel?.status == 'sent') {
        setState(() {
          requestButton = 'Cancle Request';
        });
      } else if(friendModel?.status == 'recieved') {
        setState(() {
          requestButton = 'Response';
        });
      } else {
        setState(() {
          requestButton = 'Friend';
        });
      }
    } else {
      setState(() {
        requestButton = 'Add Friend';
      });
    }
    }
    setState(() {
      isDataFetching = false;
    });
  }

  void requestAction() {
    if(widget.isMyProfile) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountManagePage()));
    }
    else {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AccountManagePage()));
    }
  }

  void friendRequestAction() {
    switch(requestButton) {
      case 'Add Friend':
      setState(() {
        requestButton = 'Cancle Request';
      });
        sendFriendRequest();
        break;
      case 'Response':
        setState(() {
          showResponseButton = true;
        });
        break;
      case 'Cancle Request':
      setState(() {
        requestButton = 'Add Friend';
      });
        cancleRequest();
        break;
      case 'Accept':
      setState(() {
        requestButton = 'Friend';
        showResponseButton = false;
        usercredentials.setFriends();
      });
        acceptFriendRequest();
        break;
      case 'Reject':
      setState(() {
        requestButton = 'Add Friend';
        showResponseButton = false;
      });
        cancleRequest();
        break;
    }
  }

  void sendFriendRequest() async {
    await _friendService.sendRequest(widget.uid);
  }

  void acceptFriendRequest() async {
    await _friendService.acceptRequest(widget.uid);
    await _friendService.updateFriendCount(widget.uid, usercredentials.friends);
  }

  void cancleRequest() async {
    await _friendService.cancleRequest(widget.uid, friendModel!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        appBar: AppBar(
          title:  Text(
            isDataFetching ? 'A moment please...' : usercredentials.userName),
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        ),
        body: isDataFetching
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              Image.asset('assets/profile.png')
                                                  .image)),
                                ),
                                const SizedBox(height: 10),
                                Text(usercredentials.bioText)
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 300,
                              height: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    usercredentials.profileName, // Profile name
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [Text('${usercredentials.posts}'), const Text('Posts')],
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FriendPage(userId: usercredentials.userName))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [Text('${usercredentials.friends}'), const Text('Friends')],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [Text('${usercredentials.likes}'), const Text('Likes')],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      actionButton(),
                      const SizedBox(height: 25),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            const TabBar(
                              indicatorColor: Colors.green,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.analytics),
                                  text: 'Details',
                                ),
                                Tab(
                                  icon: Icon(Icons.file_present),
                                  text: 'Posts',
                                )
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  profileDetails(usercredentials, context),
                                  const Center(
                                    child: Text(
                                      'No Posts Yet',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget actionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        showResponseButton
        ? responseButton()
        : GestureDetector(
          onTap: friendRequestAction,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Center(
              child: Text(
                widget.isMyProfile ? 'Create Post' : requestButton,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ),
        ),
        GestureDetector(
          onTap: requestAction,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Center(
              child: Text(
                widget.isMyProfile ? 'Edit Profile' : 'Message',
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ),
        )
      ],
    );
  }

  Widget responseButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                requestButton = 'Accept';
              });
              friendRequestAction();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12)
              ),
              child: const Icon(
                Icons.check_circle,
              ),
            ),
          ),
          const SizedBox(width: 10,),
          GestureDetector(
            onTap: () {
              setState(() {
                requestButton = 'Reject';
              });
              friendRequestAction();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12)
              ),
              child: const Icon(
                Icons.clear,
              ),
            ),
          )
        ],
      ),
    );
  }
}
