import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/profile_details.dart';

class ProfileModule extends StatelessWidget {
  const ProfileModule({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        appBar: AppBar(
          title: const Text('@user_name'),
          backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        ),
        body: SingleChildScrollView(
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
                                border: Border.all(color: Colors.white, width: 3),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        Image.asset('assets/profile.png').image)),
                          ),
                          const SizedBox(height: 10),
                          const Text('Hell yaa bitch')
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 300,
                        height: 100,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sajid Al Amin',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('0'), Text('Posts')],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('0'), Text('Friends')],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text('0'), Text('Likes')],
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
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(
                        child: Text(
                          'Create Post',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                     Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration:
                      BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(12)
                      ),
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
                            profileDetails(),
                            const Center(child: Text('No Posts Yet', style: TextStyle(fontWeight: FontWeight.bold),),)
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
