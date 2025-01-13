import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> setHandle(String handle) async {
    final String currentUserID = _firebaseAuth.currentUser!.uid;

    Map<String, dynamic> handleMap = {
      "handle" : handle,
    };

    await _firestore
      .collection("codeforces_accounts")
      .doc(currentUserID)
      .set(handleMap);
  }

  Future<String?> fetchHandle(String uid) async {
    DocumentReference docRef = _firestore.collection("codeforces_accounts").doc(uid);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.get("handle") as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching handle: $e"); // ignore: avoid_print
      return null;
    }
  }
}