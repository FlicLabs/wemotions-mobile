class Sender {
  Sender({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.profileUrl,
  });
  late final int? id;
  late final String? firstName;
  late final String? lastName;
  late final String? username;
  late final String? profileUrl;

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['profile_url'] = profileUrl;
    return _data;
  }
}
