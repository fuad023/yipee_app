import 'package:flutter/material.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/codeforces.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/iums.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    String profileName = userName[0].toUpperCase() + userName.substring(1);
    return Stack(  
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      20.0, 80.0, 20.0, 0.0),
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
                        Padding(
                          padding:
                             const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Text(
                            'Good Morning,\n$profileName',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 10, 20, 10),
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
              const Opacity(
                opacity: 0.5,
                child: SizedBox(
                  width: 300.0,
                  child: Divider(
                    height: 70.0,
                    thickness: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentIUMS(url: 'https://iums.aust.edu/ums-web/login/',))),
                              child: Material(
                                color: Colors.transparent,
                                //elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  
                                  decoration: BoxDecoration(
                                    color: const Color(0x001E3C63),
                                    borderRadius: BorderRadius.circular(30.0),
                                    border: Border.all(
                                      width: 2.0,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.school,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Iums',
                            style: TextStyle(
                              color: Color(0xBFF1F4F8),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Codeforces())),
                            child: Material(
                              color: const Color(0x75FFFFFF),
                              //elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x001E3C63),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        Image.asset('assets/cdf.png').image,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  // border: Border.all(
                                  //   width: 2.0,
                                  // ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: Color(0xBFF1F4F8),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StudentIUMS(url: 'https://drive.google.com/drive/folders/1qomc9V5zA3FetfpMYo1QSx_fXgmD0EfU?fbclid=IwY2xjawIE3XhleHRuA2FlbQIxMAABHZ4QM4lMpd6nMAupr34tAxP57Uh6waQgpzFmCyHb1ZNJZv_x6JT-tZ1q0w_aem_0tTG-pO1ksH5OCafoDU9Jw'))),
                            child: Material(
                              color: Colors.transparent,
                              //elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: const Color(0x001E3C63),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        Image.asset('assets/drive.png').image,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                  // border: Border.all(
                                  //   width: 2.0,
                                  // ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Drive',
                            style: TextStyle(
                              color: Color(0xBFF1F4F8),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Material(
                            color: Colors.transparent,
                            //elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.asset('assets/cg_calc.png')
                                      .image,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Cgpa calc',
                            style: TextStyle(
                              color: Color(0xBFF1F4F8),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
          // Display the current screen below the Stack content
        
        ],
      );
  }
}
