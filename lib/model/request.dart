import 'package:easy_blood/model/user.dart';

class Requestor {

  final String location;
  final String bloodType;
  final String reason;
  final String user_id;
  final String created_at;
  final User user;

  Requestor(this.location, this.bloodType, this.reason, this.user_id, this.created_at, this.user);

  Requestor.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        bloodType = json['bloodType'],
        reason = json['reason'],
        user_id = json['user_id'],
        created_at = json['created_at'],
        user = User.fromJson(json['user']);


  Map<String, dynamic> toJson() =>
      {
        'location': location,
        'bloodType': bloodType,
        'reason': reason,
        'user_id': user_id,
        'created_at': created_at,
      };
}