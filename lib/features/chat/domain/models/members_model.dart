class Members {
  Members({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.profileUrl,
    required this.joinedAt,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String username;
  late final String profileUrl;
  late final String joinedAt;

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    profileUrl = json['profile_url'];
    joinedAt = json['joined_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['profile_url'] = profileUrl;
    _data['joined_at'] = joinedAt;
    return _data;
  }
}
