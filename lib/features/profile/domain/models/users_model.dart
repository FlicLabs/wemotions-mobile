class Users {
  Users({
    required this.isFollowing,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
  });
  late bool isFollowing;
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String profilePictureUrl;

  Users.fromJson(Map<String, dynamic> json) {
    isFollowing = json['is_following'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePictureUrl = json['profile_picture_url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['is_following'] = isFollowing;
    _data['username'] = username;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['profile_picture_url'] = profilePictureUrl;
    return _data;
  }
}
