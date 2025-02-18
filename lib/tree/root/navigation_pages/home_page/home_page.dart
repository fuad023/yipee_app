import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/cgpa_calc.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/profile_module.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/codeforces.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/web_viewer.dart';

class HomePage extends StatelessWidget {
  final String userName;
  HomePage({
    super.key,
    required this.userName
  });

  final List<String> paths = [
    'assets/iums.png',
    'assets/cf.png',
    'assets/drive.png',
    'assets/cg_calc.png'
  ];

  final List<String> buttonNames = [
    'Iums', 'Code Forces', 'Drive', 'CGPA Calculator'
  ];

  void onIconPressed(int index, BuildContext context) {
    switch(index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewer(url: 'https://iums.aust.edu/ums-web/login/',)));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Codeforces()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewer(url: 'https://drive.google.com/drive/folders/1qomc9V5zA3FetfpMYo1QSx_fXgmD0EfU?fbclid=IwY2xjawIKb-5leHRuA2FlbQIxMAABHTonZ-Ay7iF7gfNJ1fbXAWrjIAl8jaqrLoLGFiQwMI-Kkb-KVC468CriAQ_aem_HDi06StNEeze4T-Lem-IvQ',)));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CgpaCalc(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = userName.length > 8 ? userName.substring(0, 5) : userName;
    String capsName = name[0].toUpperCase() + name.substring(1);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileModule(isMyProfile: true, uid: '',))),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: const [
                  BoxShadow(
                    color:  Color(0x334D3030),
                    offset: Offset(0.0, 3.0)
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good Morning!',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          capsName,
                          style: const TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset('assets/profile.png').image
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _homeScreenWidget(
                context: context,
                text: '20°C',
                subText: 'Friday',
                icon: Icons.cloudy_snowing,
              ),
              _homeScreenWidget(
                context: context,
                text: '2:17',
                subText: '14 January',
                icon: Icons.watch_later,
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.grey,
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                mainAxisExtent: 100,
              ),
              itemCount: paths.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onIconPressed(index, context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          ),
                          child: Center(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: Image.asset(paths[index]).image
                                )
                              ),
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Flexible(
                        flex: 1,
                        child: Text(
                          buttonNames[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _homeScreenWidget({
    required BuildContext context,
    required String text,
    required String subText,
    required IconData? icon,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: 100,
      decoration: BoxDecoration(
        //color: Colors.black,
        border: Border.all(
          color: Colors.black,
          width: 3
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black
                ),
              ),
              Text(
                subText,
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ]
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.black,),
            ]
          ),
        ],
      ),
    );
  }
}