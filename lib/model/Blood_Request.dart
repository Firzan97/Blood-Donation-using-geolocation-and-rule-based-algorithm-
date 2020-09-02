class BloodRequest {

  final String location;
  final String bloodType;
  final String reason;
  final String user_id;

  BloodRequest(this.location, this.bloodType, this.reason, this.user_id);

  BloodRequest.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        bloodType = json['bloodType'],
        reason = json['reason'],
        user_id = json['user_id'];


  Map<String, dynamic> toJson() =>
      {
        'location': location,
        'bloodType': bloodType,
        'reason': reason,
        'user_id': user_id,
      };
}