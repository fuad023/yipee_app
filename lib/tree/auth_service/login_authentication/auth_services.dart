import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';

class AuthServices {
  // Instance of firebase Authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredentials> userInformation(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _fireStore.collection("Users").doc(uid).get();

      if(documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        return UserCredentials.fromFirestore(data);
      }
      else {
        throw Exception('Unavailable');
      }
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? getCurrentUserUID() {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.uid; // This will return the UID or null if no user is logged in
}

  // Sign in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot documentSnapshot = await _fireStore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .get();

      if (!documentSnapshot.exists) {
        await _fireStore.collection("Users").doc(userCredential.user!.uid).set({
          "uid": userCredential.user!.uid,
          "email": email,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up
  Future<UserCredential> signUpWithEmailAndPassword(
      UserCredentials usercredential, String password) async {
    try {

      QuerySnapshot isUserNameExist = await _fireStore
        .collection("Users")
        .where("userName", isEqualTo: usercredential.userName)
        .get();

      if(isUserNameExist.docs.isNotEmpty) {
        throw Exception("userName already token!");
      }



      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: usercredential.email,
        password: password,
      );

      _fireStore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "name": usercredential.profileName,
        "user_id": usercredential.userName,
        "email": usercredential.email,
        "friends": usercredential.friends,
        "posts": usercredential.posts,
        "likes": usercredential.likes,
        "bio": usercredential.bioText,
        "createdAt": FieldValue.serverTimestamp(),
      });

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign in using email
  Future<void> signInWithEmail(String email) async {
    try {
      await signInWithEmail(email);
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
