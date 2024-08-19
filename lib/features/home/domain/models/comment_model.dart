class CommentModel {
  CommentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.pictureUrl,
    required this.body,
    required this.createdAt,
    required this.upvoteCount,
    required this.upvoted,
  });

  late final int id;
  late final String firstName;
  late final String lastName;
  late final String username;
  late final String pictureUrl;
  late final String body;
  late final int createdAt;
  late int upvoteCount;
  late bool upvoted;

  CommentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        username = json['username'],
        pictureUrl = json['picture_url'],
        body = json['body'],
        createdAt = json['created_at'],
        upvoteCount = json['upvote_count'],
        upvoted = json['upvoted'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['picture_url'] = pictureUrl;
    _data['body'] = body;
    _data['created_at'] = createdAt;
    _data['upvote_count'] = upvoteCount;
    _data['upvoted'] = upvoted;
    return _data;
  }
}
