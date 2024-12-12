class User {
  User({
    this.balance,
    this.token,
    this.status,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
  });

  late final int? balance;
  late final String? token;
  late final String? status;
  late final String? username;
  late final String? email;
  late final String? firstName;
  late final String? lastName;
  late final String? profilePictureUrl;

  User.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    token = json['token'];
    status = json['status'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePictureUrl = json['profile_picture_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    _data['token'] = token;
    _data['status'] = status;
    _data['username'] = username;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['profile_picture_url'] = profilePictureUrl;
    return _data;
  }
}
