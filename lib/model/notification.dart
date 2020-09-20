
class NotificationData {
  final String id;
  final String message;

 NotificationData(this.id, this.message);

  NotificationData.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        message= json['message'];


  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'message': message,
      };
}