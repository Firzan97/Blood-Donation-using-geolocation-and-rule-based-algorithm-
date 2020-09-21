
import 'package:easy_blood/model/notification.dart';

class UserNotification {
  final String id;
  final String user_id;
  final String notification_id;
  final bool is_read;
  final String created_at;
  final NotificationData notification;

  UserNotification(this.id, this.user_id, this.notification_id, this.notification, this.is_read, this.created_at);

  UserNotification.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        user_id = json['user_id'],
        notification_id = json['notification_id'],
        is_read = json['is_read'],
        created_at = json['created_at'],
        notification = NotificationData.fromJson(json['notification']);


  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'user_id': user_id,
      };
}