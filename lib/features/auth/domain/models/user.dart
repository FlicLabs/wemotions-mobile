import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.balance,
    required this.token,
    required this.status,
    required this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
  });

  final int? balance;
  final String token;
  final String status;
  final String username;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? profilePictureUrl;

  /// JSON Constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      balance: json['balance'],
      token: json['token'] ?? '',
      status: json['status'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'token': token,
      'status': status,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture_url': profilePictureUrl,
    };
  }

  /// CopyWith Method
  User copyWith({
    int? balance,
    String? token,
    String? status,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
  }) {
    return User(
      balance: balance ?? this.balance,
      token: token ?? this.token,
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  @override
  List<Object?> get props => [
        balance,
        token,
        status,
        username,
        email,
        firstName,
        lastName,
        profilePictureUrl,
      ];
}

