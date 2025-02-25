import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyStream {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getbloodDonorList() {
    return _firestore.collection('bloodDonorList').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  
}