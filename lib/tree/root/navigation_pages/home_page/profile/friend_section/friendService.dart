import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friend_model.dart';

class FriendService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _authServices = AuthServices();

  Future<void> sendRequest(String recieverId) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String uid = ids.join('_');
    Timestamp timestamp = Timestamp.now();
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).get();
      if(documentSnapshot.exists) {
        return;
      } else {
        UserCredentials sender = await _authServices.userInformation(currentUserId);
        UserCredentials reciver = await _authServices.userInformation(recieverId);
        await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).set(
          {
            'uid': uid,
            'recieverName': reciver.profileName,
            'recieverId': recieverId,
            'timeStamp': timestamp,
            'status': 'sent'
          }
        );

        await _firestore.collection('Users').doc(recieverId).collection('friends').doc(uid).set(
          {
            'uid': uid,
            'senderId': currentUserId,
            'senderName': sender.profileName,
            'timeStamp': timestamp,
            'status': 'recieved'
          }
        );
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> acceptRequest(String recieverId) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [currentUserId, recieverId];
    ids.sort();
    String uid = ids.join('_');
    try {
      await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).update(
        {
          'status': 'friends'
        }
      );
      await _firestore.collection('Users').doc(recieverId).collection('friends').doc(uid).update(
        {
          'status': 'friends'
        }
      );
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }

  Future<void> cancleRequest(String senderId, String uid) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).delete();
      await _firestore.collection('Users').doc(senderId).collection('friends').doc(uid).delete();
   } on FirebaseException catch (e) {
    throw Exception(e.hashCode);
   }
  }

  Future<void> updateFriendCount(String hostId, int friends) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestore.collection('Users').doc(currentUserId).update(
        {
          'friends': friends
        }
      );
      await _firestore.collection('Users').doc(hostId).update(
        {
          'friends': friends
        }
      );
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }

  Future<FriendModel?> getFriendInformation(String host) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> ids = [currentUserId, host];
    ids.sort();
    String uid = ids.join('_');
    try {
    DocumentSnapshot documentSnapshot = await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).get();
    if(documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      return FriendModel.fromFirestore(data);
    } else {
      return null;
    }
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }
}