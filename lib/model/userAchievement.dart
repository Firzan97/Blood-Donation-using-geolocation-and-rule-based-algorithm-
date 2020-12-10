
class UserAchievement {
  final String id;
  final String userId;
  final String achievementId;



  UserAchievement(this.id, this.userId, this.achievementId);

  UserAchievement.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        userId = json['user_id'],
        achievementId = json['achievement_id'];



  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'userId': userId,
        'achievementId': achievementId,
      };
}