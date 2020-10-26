import 'package:easy_blood/model/event.dart';

class User {
  String id;
  String username;
  String email;
  String password;
  String bloodtype;
  String phoneNumber;
  String gender;
  double latitude;
  double longitude;
  String imageURL;
  String role;
  String notificationToken;

  User(this.username, this.email, this.password, this.bloodtype, this.phoneNumber,
      this.gender, this.latitude, this.longitude, this.imageURL, this.role);

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        username = json['username'],
        email= json['email'],
        password = json['password'],
        bloodtype = json['bloodType'],
        phoneNumber = json['phoneNumber'],
        gender = json['gender'],
        latitude= double.parse(json['latitude']),
        longitude = double.parse(json['longitude']),
        imageURL = json['imageURL'],
        role = json['role'],
        notificationToken = json['notificationToken'];



  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'bloodtype': bloodtype,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'latitude': latitude,
        'longitude': longitude,
        'imageURL': imageURL,
        'role': role,
        'notificationToken': notificationToken,
      };
}
