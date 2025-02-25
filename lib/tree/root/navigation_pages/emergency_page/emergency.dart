import 'package:flutter/material.dart';
import 'package:student_app/tree/root/navigation_pages/emergency_page/emergency_stream.dart';

class BloodDonor {
  final String name;
  final String bloodType;
  final String contact;
  final String location;

  BloodDonor({
    required this.name,
    required this.bloodType,
    required this.contact,
    required this.location,
  });

}


class BloodDonorList extends StatelessWidget {
  final EmergencyStream _emergencyStream = EmergencyStream();
  final List<BloodDonor> donors = [
    BloodDonor(name: 'Nushrat Nahin', bloodType: 'A+', contact: '01817057655', location: 'Dhaka'),
    BloodDonor(name: 'Sakibul Islam', bloodType: 'O-', contact: '01833181959', location: 'Chittagong'),
    BloodDonor(name: 'Nurul Islam', bloodType: 'B+', contact: '01712235824', location: 'Barishal'),
    BloodDonor(name: 'Shahinur Islam', bloodType: 'A-', contact: '01847165825', location: 'Rajshahi'),
    BloodDonor(name: 'Nuzhat Nupur', bloodType: 'AB+', contact: '01847165826', location: 'Khulna'),
    BloodDonor(name: 'Sajid Al amin', bloodType: 'O+', contact: '01601846222', location: 'Bagerhat'),
    BloodDonor(name: 'Oditto akash dhrubo', bloodType: 'B-', contact: '0132964055', location: 'Mymensingh'),
    BloodDonor(name: 'Pantha pratick', bloodType: 'A+', contact: '0184796578', location: 'jessore'),
    BloodDonor(name: 'Siam Ahmed', bloodType: 'O-', contact: '018456789', location: 'Rangpur'),
    BloodDonor(name: 'Ashmita esha', bloodType: 'AB-', contact: '0189678435', location: 'Sylhet'),
  ];

  BloodDonorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donor List'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.yellow[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder(
          stream: _emergencyStream.getbloodDonorList(),
          builder: (context, snapshot) {
            // Error
            if (snapshot.hasError) {
              return const Text('Error');
            }

            // Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
          },
        )
        ),
      );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    BloodDonor donor = BloodDonor(name: userData['name'], bloodType: userData['bloodType'], contact: userData['contact'], location: userData['location']);
    return ListTile(
                title: Text(
                  donor.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Blood Type: ${donor.bloodType} - Location: ${donor.location}'),
                trailing: IconButton(
                  icon: const Icon(Icons.phone),
                  onPressed: () {
                    // This could be used to initiate a call or open a dialog
                    print('Calling ${donor.contact}');
                  },
                ),
                onTap: () {
                  // Show detailed donor info in a dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(donor.name),
                        content: Text(
                          'Blood Type: ${donor.bloodType}\nContact: ${donor.contact}\nLocation: ${donor.location}',
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                }
    );
  }
}