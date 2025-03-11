import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friend_model.dart';
import 'package:student_app/tree/root/notification/notification_service.dart';

class FriendService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _authServices = AuthServices();
  final NotificationService _notificationService = NotificationService();

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
            'friendName': reciver.profileName,
            'friendId': recieverId,
            'timeStamp': timestamp,
            'requestType': 'sent to',
            'status': 'sent'
          }
        );

        await _firestore.collection('Users').doc(recieverId).collection('friends').doc(uid).set(
          {
            'uid': uid,
            'friendId': currentUserId,
            'friendName': sender.profileName,
            'timeStamp': timestamp,
            'requestType': 'recieved by',
            'status': 'recieved'
          }
        );
        await _notificationService.addNotification(currentUserId, recieverId, 'sent');
      }
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> transferData(String uid, hostId) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference sourceCollectionHost = _firestore.collection('Users').doc(hostId).collection('requestSent').doc(uid);
    DocumentReference sourceCollectionCurr = _firestore.collection('Users').doc(currentUserId).collection('requestRecieved').doc(uid);

    DocumentSnapshot documentSnapshotHost = await sourceCollectionHost.get();
    DocumentSnapshot documentSnapshotCurr = await sourceCollectionCurr.get();

    if(documentSnapshotHost.exists && documentSnapshotCurr.exists) {
      Map<String, dynamic> dataHost = documentSnapshotHost.data() as Map<String, dynamic>;
      Map<String, dynamic> dataCurr = documentSnapshotCurr.data() as Map<String, dynamic>;

      await _firestore.collection('Users').doc(hostId).collection('friends').doc(uid).set(dataHost);
      await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).set(dataCurr);

      await sourceCollectionHost.delete();
      await sourceCollectionCurr.delete();
    }
  }

  Future<void> acceptRequest(String recieverId) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    UserCredentials userCredentialsHost = await _authServices.userInformation(recieverId);
    UserCredentials userCredentialsCurr = await _authServices.userInformation(currentUserId);
    userCredentialsCurr.setFriends();
    userCredentialsHost.setFriends();
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
      await _notificationService.addNotification(currentUserId, recieverId, 'accept');
      //transferData(uid, recieverId);
      updateFriendCount(recieverId, userCredentialsCurr.friends, userCredentialsHost.friends);
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }

  Future<void> cancleRequest(String senderId, String uid, bool unfriend) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    

    try {
      await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).delete();
      await _firestore.collection('Users').doc(senderId).collection('friends').doc(uid).delete();
      if(unfriend) {
        UserCredentials userCredentialsHost = await _authServices.userInformation(senderId);
        UserCredentials userCredentialsCurr = await _authServices.userInformation(currentUserId);
        userCredentialsCurr.removeFriends();
        userCredentialsHost.removeFriends();
        updateFriendCount(senderId, userCredentialsCurr.friends, userCredentialsHost.friends);
        await _notificationService.addNotification(currentUserId, senderId, 'unfriend');
      }
      await _notificationService.addNotification(currentUserId, senderId, 'cancel');
   } on FirebaseException catch (e) {
    throw Exception(e.hashCode);
   }
  }

  Future<void> updateFriendCount(String hostId, int friendsCurr, int friendsHost) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await _firestore.collection('Users').doc(currentUserId).update(
        {
          'friends': friendsCurr
        }
      );
      await _firestore.collection('Users').doc(hostId).update(
        {
          'friends': friendsHost
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
      DocumentSnapshot documentSnapshotFriends = await _firestore.collection('Users').doc(currentUserId).collection('friends').doc(uid).get();
     
      if(documentSnapshotFriends.exists) {
        Map<String, dynamic> data = documentSnapshotFriends.data() as Map<String, dynamic>;
        return FriendModel.fromFirestore(data);
      } 
      else {
       return null;
      }
    } on FirebaseException catch (e) {
      throw Exception(e.hashCode);
    }
  }
}