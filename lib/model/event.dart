import 'package:easy_blood/model/user.dart';

class Event {
  final String name;
  final String location;
  final String phoneNum;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String organizer;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String imageURL;
  final String user_id;


  Event(
    this.name,
    this.location, this.phoneNum, this.dateStart, this.dateEnd, this.organizer, this.timeStart, this.timeEnd, this.imageURL, this.user_id,
  );

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        location = json['location'],
        phoneNum = json['phoneNum'],
        dateStart = DateTime.parse(json['dateStart']),
        dateEnd = DateTime.parse(json['dateEnd']),
        organizer = json['organizer'],
        timeStart= DateTime.parse(json['timeStart']),
        timeEnd = DateTime.parse(json['timeEnd']),
        imageURL = json['imageURL'],
        user_id = json['user_id'];

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
