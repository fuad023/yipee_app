import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseUser {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String currentUserID;
  Map<String, dynamic> userInfo = {};

  DatabaseUser() {
    currentUserID = _firebaseAuth.currentUser!.uid;
  }

  // setting

  Future<void> setName(String name) async {
    Map<String, dynamic> handleMap = {"name" : name};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setUserId(String userId) async {
    Map<String, dynamic> handleMap = {"user_id" : userId};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setEmail(String email) async {
    Map<String, dynamic> handleMap = {"email" : email};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setID(String id) async {
    Map<String, dynamic> handleMap = {"id" : id};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setYear(String year) async {
    Map<String, dynamic> handleMap = {"year" : year};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setSemester(String semester) async {
    Map<String, dynamic> handleMap = {"semester" : semester};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setHandle(String handle) async {
    Map<String, dynamic> handleMap = {"handle" : handle};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  // fetching

  Future<Map<String, dynamic>> fetchData() async {
    DocumentSnapshot docSnapshot = await _firestore.collection("Users").doc(currentUserID).get();
    List<String> keys = [
      "name",  "user_id", "email", "id", "year", "semester", "handle", "uid", "phone_number", "display_picture",
    ];

    for (var key in keys) {
      dynamic field;
      try {
        field = docSnapshot.exists ? await docSnapshot.get(key) : null;
      } catch (e) {
        print("Error fetching $key: $e"); // ignore: avoid_print
        field =  null;
      }
      userInfo[key] = field;
    }
    return userInfo;
  }

  Future<String?> fetchName() async {
    DocumentReference docRef = _firestore.collection("Users").doc(currentUserID);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.get("name") as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching uinamed: $e"); // ignore: avoid_print
      return null;
    }
  }
}