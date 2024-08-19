class UserSearchModel {
  UserSearchModel({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.profilePictureUrl,
    required this.bio,
  });
  late final String firstName;
  late final String lastName;
  late final String username;
  late final String profilePictureUrl;
  late final String bio;

  UserSearchModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    username = json['username'] ?? '';
    profilePictureUrl = json['profile_picture_url'] ?? '';
    bio = json['bio'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['profile_picture_url'] = profilePictureUrl;
    _data['bio'] = bio;
    return _data;
  }
}
