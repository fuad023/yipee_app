import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/tree/auth_service/login_authentication/auth_services.dart';
import 'package:student_app/tree/auth_service/login_authentication/user_credential.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthServices _authServices = AuthServices();

  Future<void> addNotification(String senderID, String recieverId, String notificationType) async {
    UserCredentials userCredentials = await _authServices.userInformation(recieverId);
    Timestamp timestamp = Timestamp.now();
    String type = ' ';
    if(notificationType == 'sent') {
      type = 'recieved';
    }
    await _firestore.collection('Users').doc(senderID).collection('notifications').doc().set(
      {
        'type': notificationType,
        'recieverId': recieverId,
        'recieverName': userCredentials.profileName,
        'timeStamp': timestamp
      }
    );
    type.contains(' ') ? type = notificationType : 'recieved';
    await _firestore.collection('Users').doc(recieverId).collection('notificatios').doc().set(
      {
        'type': type,
        'senderId': recieverId,
        'senderName': userCredentials.profileName,
        'timeStamp': timestamp
      }
    );
  }
}