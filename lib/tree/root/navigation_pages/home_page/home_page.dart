import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<IconData> icons = [
    Icons.schedule_rounded,
    Icons.bar_chart,
    Icons.drive_eta_outlined,
    Icons.calculate_outlined
  ];



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                    onTap: () {},
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
                        const Flexible(
                          flex: 1,
                          child: Text(
                            'Sajid'
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