import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // Instance of firebase Authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Sign in
  Future<UserCredential> signwithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot documentSnapshot = await _firestore
          .collection("Users")
          .doc(userCredential.user!.uid)
          .get();

      if (!documentSnapshot.exists) {
        await _firestore.collection("Users").doc(userCredential.user!.uid).set({
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
  Future<UserCredential> signUpwithEmailandPassword(
      String email, password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
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

  // Delete Account
  // Future<void> deleteAccount() async {
  //   try {
  //   await _firestore.collection('Users').doc(_firebaseAuth.currentUser?.uid).delete();
  //   await _firebaseAuth.currentUser!.delete();
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
  Future<void> deleteAccount(String pass) async {
  try {
    // Get the current user
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      // Re-authenticate the user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: pass, // Prompt the user to enter their password
      );

      await user.reauthenticateWithCredential(credential);

      // Delete user data from Firestore
      await _firestore.collection('Users').doc(user.uid).delete();

      // Delete the user account
      await user.delete();
    }
  } on FirebaseAuthException catch (e) {
    throw Exception(e.toString());
  }
}


}
