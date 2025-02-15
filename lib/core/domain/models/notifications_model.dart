class Notifications {
  final int id;
  final User user;
  final Actor actor;
  final String actionType;
  final String? hasSeen;
  final String content;
  final String? targetId;
  final String contentAvatarUrl;
  final String createdAt;

  Notifications({
    required this.id,
    required this.user,
    required this.actor,
    required this.actionType,
    this.hasSeen,
    required this.content,
    this.targetId,
    required this.contentAvatarUrl,
    required this.createdAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'] as int,
      user: User.fromJson(json['user']),
      actor: Actor.fromJson(json['actor']),
      actionType: json['action_type'] as String,
      hasSeen: json['has_seen'] as String?,
      content: json['content'] as String,
      targetId: json['target_id'] as String?,
      contentAvatarUrl: json['content_avatar_url'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'actor': actor.toJson(),
        'action_type': actionType,
        'has_seen': hasSeen,
        'content': content,
        'target_id': targetId,
        'content_avatar_url': contentAvatarUrl,
        'created_at': createdAt,
      };
}

class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String name;
  final String profileUrl;
  final bool? isFollowing;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.profileUrl,
    this.isFollowing,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      profileUrl: json['profile_url'] as String,
      isFollowing: json['is_following'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'name': name,
        'profile_url': profileUrl,
        'is_following': isFollowing,
      };
}

class Actor {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String name;
  final String profileUrl;
  final bool? isFollowing;

  Actor({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.profileUrl,
    this.isFollowing,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'] as int,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      name: json['name'] as String,
      profileUrl: json['profile_url'] as String,
      isFollowing: json['is_following'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'name': name,
        'profile_url': profileUrl,
        'is_following': isFollowing,
      };
}
