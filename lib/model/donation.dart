class Donation {


  final String request_id;
  final String donor_id;
  final String donated_at;

  Donation(this.request_id, this.donor_id, this.donated_at);

  Donation.fromJson(Map<String, dynamic> json)
      : request_id = json['request_id'],
        donor_id = json['donor_id'],
        donated_at = json['donated_at'];

  Map<String, dynamic> toJson() =>
      {
        'request_id': request_id,
        'donor_id': donor_id,
        'donated_at': donated_at
      };
}