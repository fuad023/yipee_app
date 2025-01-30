import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountDatabaseService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String currentUserID;
  Map<String, dynamic> userInfo = {};

  AccountDatabaseService() {
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

  // Future<void> setEmail(String email) async {
  //   Map<String, dynamic> handleMap = {"handle" : email};

  //   await _firestore
  //     .collection("Users")
  //     .doc(currentUserID)
  //     .set(
  //       handleMap,
  //       SetOptions(merge: true),
  //     );
  // }

  Future<void> setYear(int year) async {
    Map<String, dynamic> handleMap = {"year" : year};

    await _firestore
      .collection("Users")
      .doc(currentUserID)
      .set(
        handleMap,
        SetOptions(merge: true),
      );
  }

  Future<void> setSemester(int semester) async {
    Map<String, dynamic> handleMap = {"semester" : semester};

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
      "email", "uid", "name",  "username", "year", "semester", "id", "phone_number", "display_picture",
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

  Future<String?> fetchEmail() async {
    DocumentReference docRef = _firestore.collection("Users").doc(currentUserID);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.get("email") as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching email: $e"); // ignore: avoid_print
      return null;
    }
  }

  Future<String?> fetchUID() async {
    DocumentReference docRef = _firestore.collection("Users").doc(currentUserID);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.get("uid") as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching uid: $e"); // ignore: avoid_print
      return null;
    }
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

  Future<String?> fetchYear() async {
    DocumentReference docRef = _firestore.collection("Users").doc(currentUserID);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.get("year") as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching year: $e"); // ignore: avoid_print
      return null;
    }
  }

  Future<String?> fetchSemester() async {
    DocumentReference docRef = _firestore.collection("Users").doc(currentUserID);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        return docSnapshot.get("semester") as String?;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching semester: $e"); // ignore: avoid_print
      return null;
    }
  }

  Future<String?> fetchHandle() async {
    DocumentReference docRef = _firestore.collection("Users").doc(currentUserID);

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