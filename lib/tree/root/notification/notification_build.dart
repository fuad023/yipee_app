import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/tree/root/notification/notification_model.dart';

class NotificationBuild {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<NotificationModel>> getNotificationStream(String uid) {
    return _firestore
        .collection('Users')
        .doc(uid)
        .collection('notifications')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return NotificationModel.fromFirestore(doc.data());
          }).toList();
        });
  }
}