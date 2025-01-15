import 'package:flutter/material.dart';
import 'package:student_app/components/image_or_text_button.dart';
import 'package:student_app/pages/auth/root/nagivation_pages/home_page/services/codeforces/codeforces.dart';

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
        return switch (index) {
          
          0 => ImageOrTextButton(
            text: 'assets/codeforces.png',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Codeforces()))
          ),

          1 => ImageOrTextButton(
            text: '    Math\nCalculator',
            onTap: () {},
          ),

          2 => ImageOrTextButton(
            text: '    CGPA\nCalculator',
            onTap: () {},
          ),

          3 => ImageOrTextButton(
            text: '   Study\nMaterials',
            onTap: () {},
          ),

          4 => ImageOrTextButton(
            text: 'YipeeGPT',
            onTap: () {},
          ),

          5 => ImageOrTextButton(
            text: 'Shop',
            onTap: () {},
          ),

          int() => ImageOrTextButton(
            text: 'Button $index',
            onTap: () {},
          ),
        };
      },
    );
  }
}
