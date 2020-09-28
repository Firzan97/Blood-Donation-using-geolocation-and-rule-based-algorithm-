
import 'package:easy_blood/model/user.dart';

class Conversation {
  final String id;
  final String userSendId;
  final String userReceiveId;
  final User userReceive;


  Conversation(this.id, this.userSendId, this.userReceiveId, this.userReceive);

  Conversation.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        userSendId = json['userSendId'],
        userReceiveId = json['userReceiveId'],
        userReceive= User.fromJson(json['user_receive']);


  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'userId': userSendId,
        'message': userReceiveId,
        'user_receive': userReceive,
      };
}