class User {
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

  User(this.username, this.email, this.password, this.bloodtype, this.phoneNumber,
      this.gender, this.latitude, this.longitude, this.imageURL, this.role);

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email= json['email'],
        password = json['password'],
        bloodtype = json['bloodType'],
        phoneNumber = json['phoneNumber'],
        gender = json['gender'],
        latitude= double.parse(json['latitude']),
        longitude = double.parse(json['longitude']),
        imageURL = json['imageURL'],
        role = json['role'];

  Map<String, dynamic> toJson() =>
      {
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
      };
}
