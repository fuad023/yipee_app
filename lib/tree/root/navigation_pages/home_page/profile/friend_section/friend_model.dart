import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel {
  final String uid;
  final String friendId;
  final String friendName;
  final Timestamp timeStamp;
  final String requestType;
  String status;

  FriendModel({
    required this.uid,
    required this.friendId,
    required this.friendName,
    required this.timeStamp,
    required this.requestType,
    required this.status
  });

  void changeStatus(String newStatus) {
    status = newStatus;
  }

  factory FriendModel.fromFirestore(Map<String, dynamic> data) {
    return FriendModel(
      uid: data['uid'] ?? 'Invalid',
      friendId: data['friendId'] ?? 'Invalid', 
      friendName: data['friendName'] ?? 'Invalid',
      timeStamp: data['timeStamp'] ?? 'Invalid', 
      requestType: data['requestType'] ?? 'Invalid',
      status: data['status'] ?? 'Invalid'
    );
  }
  
}