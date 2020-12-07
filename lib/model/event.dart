import 'package:easy_blood/model/user.dart';

class Event {
  final String id;
  final String name;
  final String location;
  final String phoneNum;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String organizer;
  final String timeStart;
  final String timeEnd;
  final String imageURL;
  final String user_id;
  final String created_at;
//  final User user;

  Event(
    this.name,
    this.location, this.phoneNum, this.dateStart, this.dateEnd, this.organizer, this.timeStart, this.timeEnd, this.imageURL, this.user_id, this.id, this.created_at,
  );

  Event.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        location = json['location'],
        phoneNum = json['phoneNum'],
        dateStart = DateTime.parse(json['dateStart']),
        dateEnd = DateTime.parse(json['dateEnd']),
        organizer = json['organizer'],
        timeStart= json['timeStart'],
        timeEnd = json['timeEnd'],
        imageURL = json['imageURL'],
        user_id = json['user_id'],
        created_at = json['created_at'];
//        user = User.fromJson(json['user']);

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'location': location,
        'phoneNum': phoneNum,
        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'organizer': organizer,
        'timeStart': timeStart,
        'timeEnd': timeEnd,
        'imageURL': imageURL,
        'user_id': user_id,
      };
}
