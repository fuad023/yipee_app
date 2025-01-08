import 'package:cloud_firestore/cloud_firestore.dart';


class Messaging {
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String message;
  final Timestamp timestamp;

  Messaging({
    required this.senderID,
    required this.senderEmail,
    required this.recieverID,
    required this.message,
    required this.timestamp,
  });

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'senderEmail': recieverID,
      'recieverID': recieverID,
      'message': message,
      'timestamp': timestamp,
    };
  }

  // // Convert Firestore document into a Messaging object
  // factory Messaging.fromMap(Map<String, dynamic> map) {
  //   return Messaging(
  //     senderID: map["senderID"],
  //     senderEmail: map["senderEmail"],
  //     recieverID: map["receiverID"],
  //     message: map["message"],
  //     timestamp: map["timestamp"] ?? Timestamp.now(), // Ensure correct type
  //   );
  // }

}