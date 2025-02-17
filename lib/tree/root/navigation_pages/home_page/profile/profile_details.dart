import 'package:flutter/material.dart';

Widget profileDetails() {
  return const Padding(
    padding: EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.school,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Ahsanullah University of Science & Technology',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.business_center,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Computer Science & Technology',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.email,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(
                    'sajid.cse.20230104025@aust.edu',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '@DJ_12',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}