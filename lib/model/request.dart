class Requestor {

  final String location;
  final String bloodType;
  final String reason;
  final String user_id;
  final String created_at;

  Requestor(this.location, this.bloodType, this.reason, this.user_id, this.created_at);

  Requestor.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        bloodType = json['bloodType'],
        reason = json['reason'],
        user_id = json['user_id'],
        created_at = json['created_at'];


  Map<String, dynamic> toJson() =>
      {
        'location': location,
        'bloodType': bloodType,
        'reason': reason,
        'user_id': user_id,
        'created_at': created_at,
      };
}