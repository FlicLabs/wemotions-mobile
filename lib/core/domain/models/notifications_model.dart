class Notifications {
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

  late final int id;
  late final CurrUser user;
  late final Actor actor;
  late final String actionType;
  late final String? hasSeen;
  late final String content;
  late final String? targetId;
  late final String contentAvatarUrl;
  late final String createdAt;

  Notifications.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = CurrUser.fromJson(json['user']),
        actor = Actor.fromJson(json['actor']),
        actionType = json['action_type'],
        hasSeen = json['has_seen'],
        content = json['content'],
        targetId = json['target_id'],
        contentAvatarUrl = json['content_avatar_url'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'user':  user.toJson(),
      'actor': actor.toJson(),
      'action_type': actionType,
      'has_seen': hasSeen,
      'content': content,
      'target_id': targetId,
      'content_avatar_url': contentAvatarUrl,
      'created_at': createdAt,
    };
    return data;
  }
}

class CurrUser {
  CurrUser({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.profileUrl,
    this.isFollowing,
  });

  late final int id;
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String profileUrl;
  late final bool? isFollowing;

  CurrUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        name = json['name'],
        profileUrl = json['profile_url'],
        isFollowing = json['is_following'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'name': name,
      'profile_url': profileUrl,
      'is_following': isFollowing,
    };
    return data;
  }
}

class Actor {
  Actor({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.profileUrl,
    this.isFollowing,
  });

  late final int id;
  late final String username;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String profileUrl;
  late bool? isFollowing;

  Actor.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        name = json['name'],
        profileUrl = json['profile_url'],
        isFollowing = json['is_following'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'name': name,
      'profile_url': profileUrl,
      'is_following': isFollowing,
    };
    return data;
  }
}
