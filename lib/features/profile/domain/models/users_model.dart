import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final bool isFollowing;
  final String username;
  final String firstName;
  final String lastName;
  final String profilePictureUrl;

  const Users({
    required this.isFollowing,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
  });

  /// Default empty instance
  static const empty = Users(
    isFollowing: false,
    username: '',
    firstName: '',
    lastName: '',
    profilePictureUrl: '',
  );

  /// Factory constructor for safer JSON parsing
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      isFollowing: json['is_following'] ?? false,
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profilePictureUrl: json['profile_picture_url'] ?? '',
    );
  }

  /// Converts the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'is_following': isFollowing,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture_url': profilePictureUrl,
    };
  }

  /// Allows partial updates without recreating the whole object
  Users copyWith({
    bool? isFollowing,
    String? username,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
  }) {
    return Users(
      isFollowing: isFollowing ?? this.isFollowing,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  @override
  List<Object> get props => [
        isFollowing,
        username,
        firstName,
        lastName,
        profilePictureUrl,
      ];
}
