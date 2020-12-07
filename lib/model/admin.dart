
class Admin {
  String id;
  String username;
  String email;
  String password;
  String role;
  String notificationToken;
  String imageURL;


  Admin(this.id,this.username, this.email, this.password, this.role,this.notificationToken, this.imageURL);

  Admin.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        username = json['username'],
        email= json['email'],
        password = json['password'],
        role = json['role'],
        imageURL = json['imageURL'],
      notificationToken = json['notificationToken'];





  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'role': role,
        'imageURL': imageURL,
        'notificationToken': notificationToken,
      };
}