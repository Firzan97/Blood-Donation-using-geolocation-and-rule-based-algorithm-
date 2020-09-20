
import 'package:easy_blood/model/notification.dart';

class UserNotification {
  final String id;
  final String user_id;
  final String notification_id;
  final NotificationData notification;

  UserNotification(this.id, this.user_id, this.notification_id, this.notification);

  UserNotification.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        user_id = json['user_id'],
        notification_id = json['notification_id'],
        notification = NotificationData.fromJson(json['notification']);


  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'user_id': user_id,
      };
}