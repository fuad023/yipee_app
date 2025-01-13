import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/home.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/message.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/emergency.dart';
import 'package:student_app/pages/auth/root/drawer_screen.dart';

class RootPage extends StatefulWidget {
  
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    MessagePage(),
    const EmergencyPage(),
  ];

  @override
  Widget build(BuildContext context) {
  final User? user = FirebaseAuth.instance.currentUser;
  final String userName = user?.email ?? 'No email';

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'YieppeApp',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF2b5f56),
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          elevation: 10.0,
        ),
        drawer: DrawerScreen(email: userName,),
        body: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, 0.0),
              child: ClipRRect(
                child: Image.asset(
                  'assets/home_bg.png',
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.0, 0.0),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: const Color(0x44FFFFFF),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Color(0x334D3030),
                            offset: Offset(
                              0.0,
                              12.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      
                      alignment: const AlignmentDirectional(-1.0, -1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                            child: Text(
                              'Good Morning!\nSajid',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset(
                                    'assets/profine.png',
                                  ).image,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 165.0,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0x44FFFFFF),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '30°C',
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Friday',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.cloudy_snowing,
                                size: 50.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 165.0,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0x44FFFFFF),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '2:17',
                                    style: TextStyle(
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '14 JAN',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.watch_later,
                                size: 50.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}