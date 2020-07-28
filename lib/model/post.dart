class Post {
  final String title;
  final String body;
  final String id;

  Post({
    this.title,
    this.body,
    this.id
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      id: json['id'],
      body: json['body'],
    );
  }
}