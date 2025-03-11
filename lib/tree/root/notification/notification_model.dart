import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String type;
  final String recieverId;
  final String recieverName;
  final Timestamp timeStamp;

  NotificationModel({
    required this.type,
    required this.recieverId,
    required this.recieverName,
    required this.timeStamp,
  });

  factory NotificationModel.fromFirestore(Map<String, dynamic> data) {
    return NotificationModel(
      type: data['type'] ?? 'Invalid',
      recieverId: data['recieverId'] ?? 'Invalid', 
      recieverName: data['recieverName'] ?? 'Invalid',
      timeStamp: data['timeStamp'] ?? 'Invalid', 
    );
  }
  
}