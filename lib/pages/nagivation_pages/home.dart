import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
      ),
      padding: const EdgeInsets.all(10.0),
      itemCount: 9, // Total number of buttons
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Define button action here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Button $index pressed')),
            );
          },
          child: switch (index) {
            0 => Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/codeforces.png'),
                  fit: BoxFit.cover, // Ensures the image covers the button
                ),
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
            ),
            1 => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              alignment: Alignment.center,
              child: const Text(
                '    Math\nCalculator',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
            2 => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              alignment: Alignment.center,
              child: const Text(
                '    CGPA\nCalculator',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
            3 => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              alignment: Alignment.center,
              child: const Text(
                '   Study\nMaterials',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
            4 => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              alignment: Alignment.center,
              child: const Text(
                'YipeeGPT',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
            5 => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              alignment: Alignment.center,
              child: const Text(
                'Shop',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
            int() => Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white),
              alignment: Alignment.center,
              child: Text(
                'Button $index',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
          }
        );
      },
    );
  }
}
