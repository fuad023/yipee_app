import 'package:flutter/material.dart';
import 'package:student_app/tree/root/notification/notification_build.dart';
import 'package:student_app/tree/root/notification/notification_model.dart';

class NotificationPage extends StatelessWidget {
  final NotificationBuild _notificationBuild = NotificationBuild();
  final String uid;
  NotificationPage({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications'
        ),
      ),
      body: StreamBuilder(
        stream: _notificationBuild.getNotificationStream(uid), 
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading Notifications"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Notifications available"));  
          }
      
          List<NotificationModel> notificationList = snapshot.data!;
      
          return ListView.builder(
            itemCount: notificationList.length,
            itemBuilder: (context, index) => _buildNotificationTile(context, notificationList[index])
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(BuildContext context, NotificationModel notification_model) {
    
    String title = ' ';
    switch(notification_model.type){
      case 'sent':
        title = 'You sent friend request to ${notification_model.recieverName}';
        break;
      case 'recieved':
        title = '${notification_model.recieverName} sent you friend request ';
        break;
      case 'cancel':
        title = '${notification_model.recieverName} denied your friend request ';
        break;
      case 'accept':
        title = '${notification_model.recieverName} accepted your request ';
        break;
      case 'unfriend':
        title = '${notification_model.recieverName} removed you from his list ';
        break;
    } 
    return ListTile(
      title: Text(
        title
      ),
    );
  }
}