import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/profile_details.dart';

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
  bool isDataFetching = true;
  late UserCredentials usercredentials;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String uid = widget.isMyProfile ? _authServices.getCurrentUserUID() ?? '0' : widget.uid;
    usercredentials = await _authServices.userInformation(uid);
    setState(() {
      isDataFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        appBar: AppBar(
          title:  Text(
            isDataFetching ? 'Wait...' : usercredentials.userName),
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        ),
        body: isDataFetching
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                //physics: const BouncingScrollPhysics(),
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [Text('${usercredentials.friends}'), const Text('Friends')],
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
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                widget.isMyProfile
                                    ? 'Create Post'
                                    : 'Add friend',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.45,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.isMyProfile
                                        ? Icons.edit
                                        : Icons.message_outlined,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    widget.isMyProfile
                                        ? 'Edit Profile'
                                        : 'Message',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.55,
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
                                  profileDetails(usercredentials),
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
}
