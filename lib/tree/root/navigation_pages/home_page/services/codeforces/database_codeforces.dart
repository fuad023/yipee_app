import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseCodeforces {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String currentUserID;

  DatabaseCodeforces() {
    currentUserID = _firebaseAuth.currentUser!.uid;
  }

  // Future<void> setHandle(String handle) async {
  //   final String currentUserID = _firebaseAuth.currentUser!.uid;

  //   Map<String, dynamic> handleMap = {
  //     "handle" : handle,
  //   };

  //   await _firestore
  //     .collection("codeforces_accounts")
  //     .doc(currentUserID)
  //     .set(handleMap);
  // }

  Future<String?> fetchHandle() async {
    DocumentReference docRef = _firestore
                                  .collection("Users")
                                  .doc(currentUserID);

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