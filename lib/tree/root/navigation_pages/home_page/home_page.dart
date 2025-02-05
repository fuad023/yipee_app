import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/cgpa_calc.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/codeforces/codeforces.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/services/web_viewer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<IconData> icons = [
    Icons.school,
    Icons.bar_chart,
    Icons.drive_folder_upload,
    Icons.calculate_outlined
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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 125,
              decoration: BoxDecoration(
                color: const Color.fromARGB(54, 255, 255, 255),
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
                  const Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Good Morning!',
                          style: TextStyle(
                            fontSize: 20.0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Sajid Al Amin',
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
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
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(54, 255, 255, 255),
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: const [
                      BoxShadow(
                        color:  Color(0x334D3030),
                        offset: Offset(0.0, 3.0)
                      )
                    ]
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '20°C',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                          Text(
                            'Friday'
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloudy_snowing,
                            size: 40,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(54, 255, 255, 255),
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: const [
                      BoxShadow(
                        color:  Color(0x334D3030),
                        offset: Offset(0.0, 3.0)
                      )
                    ]
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2:17',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                          Text(
                            '14 January'
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.watch_later,
                            size: 40,
                          )
                        ],
                      )
                    ],
                  ),
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
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 100,
                ),
                itemCount: icons.length,
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
                              child: Icon(
                                icons[index],
                                size: 40,
                              ),
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
      ),
    );
  }
}