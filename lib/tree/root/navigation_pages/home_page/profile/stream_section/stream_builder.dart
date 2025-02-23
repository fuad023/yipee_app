import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/tree/root/navigation_pages/home_page/profile/friend_section/friend_model.dart';

class FriendStreamBuild {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<FriendModel>> getUserList(String uid, collectionType) {
    return _firestore.collection('Users').doc(uid).collection('friends').where('status', isEqualTo: collectionType).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FriendModel.fromFirestore(doc.data());
      }).toList();
    });
  }
}