import 'package:easy_blood/model/user.dart';

class Request {

  final String _id;
  final String location;
  final String bloodType;
  final String reason;
  final String user_id;

  Request(this._id, this.location, this.bloodType, this.reason, this.user_id);


}