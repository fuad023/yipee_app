import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final String uid;
  final String senderId;
  final String recieverId;
  final String senderName;
  final String recieverName;
  final Timestamp timeStamp;
  String status;

  FriendModel({
    required this.uid,
    required this.senderId,
    required this.recieverId,
    required this.senderName,
    required this.recieverName,
    required this.timeStamp,
    required this.status
  });

  void changeStatus(String newStatus) {
    status = newStatus;
  }

  factory FriendModel.fromFirestore(Map<String, dynamic> data) {
    return FriendModel(
      uid: data['uid'] ?? 'Invalid',
      senderId: data['senderId'] ?? 'Invalid', 
      recieverId: data['recieverId'] ?? 'Invalid', 
      senderName: data['senderName'] ?? 'Invalid',
      recieverName: data['recieverName'] ?? 'Invalid',
      timeStamp: data['timeStamp'] ?? 'Invalid', 
      status: data['status'] ?? 'Invalid'
    );
  }
  
}