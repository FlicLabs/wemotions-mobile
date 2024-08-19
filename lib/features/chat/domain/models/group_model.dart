class Group {
  Group({
    required this.id,
    required this.title,
    required this.description,
    required this.profileUrl,
    required this.createdAt,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String profileUrl;
  late final String createdAt;

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    profileUrl = json['profile_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['profile_url'] = profileUrl;
    _data['created_at'] = createdAt;
    return _data;
  }
}
