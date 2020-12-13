
class Leaderboard {
  final String donorId;
  final String username;
  final int count;
  final String imageURL;



  Leaderboard(this.donorId, this.username, this.count, this.imageURL);

  Leaderboard.fromJson(Map<String, dynamic> json)
      : donorId = json['donor_id'],
        username = json['username'],
        count = json['count'],
        imageURL = json['imageURL'];



  Map<String, dynamic> toJson() =>
      {
        'donorId': donorId,
        'username': username,
        'count': count,
        'imageURL': imageURL,

      };
}