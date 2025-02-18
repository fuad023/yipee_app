import 'package:flutter/material.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';

Widget profileDetails(UserCredentials usercredential) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const Row(
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
          const SizedBox(height: 20),
          const Row(
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
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.email,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SelectableText(
                    usercredential.email,
                    style: const TextStyle(
                      fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.bar_chart,
                size: 30,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    usercredential.handle,
                    style: const TextStyle(
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