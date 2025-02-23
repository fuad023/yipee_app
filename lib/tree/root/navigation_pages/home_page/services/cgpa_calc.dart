import 'package:flutter/material.dart';

class CgpaCalc extends StatefulWidget {
  const CgpaCalc({super.key});

  @override
  State<CgpaCalc> createState() => _CgpaCalcState();
}

class Item {
  String optionName;
  double optionData;
  Item(this.optionName, this.optionData);
}

class _CgpaCalcState extends State<CgpaCalc> {
  final List<Item?> selectedItems = [];
  final List<Item?> selectedItems2 = [];
  List<Item> items = [
    Item('Credit', 4.00),
    Item('Credit', 3.00),
    Item('Credit', 2.00),
    Item('Credit', 1.50),
    Item('Credit', 0.75)
  ];
  List<Item> items2 = [
    Item('A+', 4.00),
    Item('A ', 3.75),
    Item('A-', 3.50),
    Item('B+', 3.25),
    Item('B ', 3.00),
    Item('B-', 2.75),
    Item('C+', 2.50),
    Item('C ', 2.25),
    Item('D', 2.00),
  ];
  @override
  void initState() {
    super.initState();
    selectedItems.add(items[0]);
    selectedItems2.add(items2[0]);
  }

  void addCourse() {
    setState(() {
      selectedItems.add(items[0]);
      selectedItems2.add(items2[0]);
    });
  }

  void deleteCourse() {
    setState(() {
      if(selectedItems.isNotEmpty) {
        selectedItems.removeLast();
        selectedItems2.removeLast();
      }
    });
  }

  void calculateCgpa() {
    double totalCredit = 0;
    double totalGradePoint = 0;

    for (int i = 0; i < selectedItems.length; ++i) {
      final credit = selectedItems[i]?.optionData ?? 0;
      final grade = selectedItems2[i]?.optionData ?? 0;

      totalGradePoint += credit * grade;
      totalCredit += credit;
    }

    if (totalCredit == 0) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Error'),
              content: Text('Input All credits'),
            );
          });
      return;
    }

    final cgpa = totalGradePoint / totalCredit;
    String ogcg = cgpa.toStringAsFixed(2);
    showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Calculated CGPA'),
              content:  Text(ogcg),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const Text('Ok'),
                )
              ],
            );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        title: const Text(
          'CGPA Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(94, 76, 175, 79)),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          ...selectedItems.asMap().entries.map((entry) {
                            final index = entry.key;
                            final selectedItem = entry.value;
                            return Container(
                                width: 150,
                                height: 50,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: DropdownButton<Item>(
                                  value: selectedItem,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      selectedItems[index] = newValue;
                                    });
                                  },
                                  items: items
                                      .map<DropdownMenuItem<Item>>((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                          '${item.optionName} : ${item.optionData}'),
                                    );
                                  }).toList(),
                                ));
                          }),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        children: [
                          ...selectedItems2.asMap().entries.map((entry) {
                            final index = entry.key;
                            final selectedItem2 = entry.value;
                            return Container(
                                width: 150,
                                height: 50,
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: DropdownButton<Item>(
                                  value: selectedItem2,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      selectedItems2[index] = newValue;
                                    });
                                  },
                                  items: items2
                                      .map<DropdownMenuItem<Item>>((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              '${item.optionData}',
                                            ),
                                            const SizedBox(width: 20,),
                                          Text(
                                            '(${item.optionName})',
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ));
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextButton.icon(
                      onPressed: addCourse,
                      label: const Text('Add Course'),
                      icon: const Icon(Icons.add),
                  )
                ),
                const SizedBox(width: 10,),
            const SizedBox(width: 10,),
            Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextButton.icon(
                      onPressed: deleteCourse,
                      label: const Text('Delete Course'),
                      icon: const Icon(Icons.remove),
                  )
                ),
              ],
          ),
          const SizedBox(height: 5,),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: TextButton(
                  onPressed: () {
                    calculateCgpa();
                  },
                  child: const Text('Calculate')
                ),
            ),
        ],
        ),
      ),
    );
  }
}
