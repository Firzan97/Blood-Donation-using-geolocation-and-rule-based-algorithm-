
class Message {
  final String id;
  final String userSendId;
  final String message;


  Message(this.id, this.userSendId, this.message);

  Message.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        userSendId = json['userId'],
        message = json['message'];


  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'userId': userSendId,
        'message': message,
      };
}