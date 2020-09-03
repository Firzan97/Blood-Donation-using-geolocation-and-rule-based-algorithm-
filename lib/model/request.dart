class Requestor {

  final String location;
  final String bloodType;
  final String reason;
  final String user_id;
  final DateTime createdAt;

  Requestor(this.location, this.bloodType, this.reason, this.user_id, this.createdAt);

  Requestor.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        bloodType = json['bloodType'],
        reason = json['reason'],
        user_id = json['user_id'],
        createdAt = json['created_at'];


  Map<String, dynamic> toJson() =>
      {
        'location': location,
        'bloodType': bloodType,
        'reason': reason,
        'user_id': user_id,
        'created_at': createdAt,
      };
}