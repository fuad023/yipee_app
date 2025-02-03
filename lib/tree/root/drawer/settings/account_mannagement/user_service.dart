import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  User? user = FirebaseAuth.instance.currentUser;

  String getCurrentUserEmail() {
    return user?.email ?? 'No User Email';
  }

  Future<void> verifyUser(String email, password) async {
    if(user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password
      );

      try {
        await user?.reauthenticateWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        throw Exception(e.hashCode);
      }
    }
  }

  Future<void> updateEmail(String newEmail) async {
    if(user != null) {
      try {
        await user?.verifyBeforeUpdateEmail(newEmail);
      } on FirebaseException catch (e) {
        throw Exception(e.hashCode);
      }
    }
  }

  Future<void> updatePassword(String newPassword) async {
    if(user != null) {
      try {
        await user?.updatePassword(newPassword);
      } on FirebaseAuthException catch (e) {
        throw Exception(e.hashCode);
      }
    }
  }

  Future<void> deleteAccount() async {
    try {
      await user?.delete();
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }
}