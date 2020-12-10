
class Achievement {
  final String id;
  final String type;
  final String description;
  final String imageURL;



  Achievement(this.id, this.type, this.description, this.imageURL);

  Achievement.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        type = json['type'],
        description = json['description'],
        imageURL = json['imageURL'];



  Map<String, dynamic> toJson() =>
      {
        '_id': id,
        'type': type,
        'description': description,
        'imageURL': imageURL,

      };
}