class Posts {
  final int id;
  final String slug;
  final String title;
  final String identifier;
  final int commentCount;
  final int upvoteCount;
  final int viewCount;
  final int shareCount;
  final String videoLink;
  final bool isLocked;
  final int createdAt;
  final String firstName;
  final String lastName;
  final String username;
  final bool upvoted;
  final bool bookmarked;
  final String thumbnailUrl;
  final bool following;
  final String pictureUrl;
  final int votingCount;
  final List<Votings> votings;
  final List<Tags> tags;
  final int childVideoCount;

  Posts({
    required this.id,
    required this.slug,
    required this.title,
    required this.identifier,
    required this.commentCount,
    required this.upvoteCount,
    required this.viewCount,
    required this.shareCount,
    required this.videoLink,
    required this.isLocked,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.upvoted,
    required this.bookmarked,
    required this.thumbnailUrl,
    required this.following,
    required this.pictureUrl,
    required this.votingCount,
    required this.votings,
    required this.tags,
    required this.childVideoCount,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      id: json['id'] as int,
      slug: json['slug'] as String,
      title: json['title'] as String,
      identifier: json['identifier'] as String,
      commentCount: json['comment_count'] as int,
      upvoteCount: json['upvote_count'] as int,
      viewCount: json['view_count'] as int,
      shareCount: json['share_count'] as int,
      videoLink: json['video_link'] as String,
      isLocked: json['is_locked'] as bool,
      createdAt: json['created_at'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      upvoted: json['upvoted'] as bool,
      bookmarked: json['bookmarked'] as bool,
      thumbnailUrl: json['thumbnail_url'] as String,
      following: json['following'] as bool,
      pictureUrl: json['picture_url'] as String,
      votingCount: json['voting_count'] as int,
      votings: (json['votings'] as List).map((e) => Votings.fromJson(e)).toList(),
      tags: (json['tags'] as List).map((e) => Tags.fromJson(e)).toList(),
      childVideoCount: json['child_video_count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'title': title,
        'identifier': identifier,
        'comment_count': commentCount,
        'upvote_count': upvoteCount,
        'view_count': viewCount,
        'share_count': shareCount,
        'video_link': videoLink,
        'is_locked': isLocked,
        'created_at': createdAt,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'upvoted': upvoted,
        'bookmarked': bookmarked,
        'thumbnail_url': thumbnailUrl,
        'following': following,
        'picture_url': pictureUrl,
        'voting_count': votingCount,
        'votings': votings.map((e) => e.toJson()).toList(),
        'tags': tags.map((e) => e.toJson()).toList(),
        'child_video_count': childVideoCount,
      };
}

class Votings {
  final int id;
  final String votingIcon;
  final VotingUserData user;
  final String createdAt;

  Votings({
    required this.id,
    required this.votingIcon,
    required this.user,
    required this.createdAt,
  });

  factory Votings.fromJson(Map<String, dynamic> json) {
    return Votings(
      id: json['id'] as int,
      votingIcon: json['voting_icon'] as String,
      user: VotingUserData.fromJson(json['user']),
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'voting_icon': votingIcon,
        'user': user.toJson(),
        'created_at': createdAt,
      };
}

class Tags {
  final int id;
  final VotingUserData user;
  final String createdAt;

  Tags({
    required this.id,
    required this.user,
    required this.createdAt,
  });

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      id: json['id'] as int,
      user: VotingUserData.fromJson(json['user']),
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'created_at': createdAt,
      };
}

class VotingUserData {
  final String firstName;
  final String lastName;
  final String username;
  final String pictureUrl;

  VotingUserData({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.pictureUrl,
  });

  factory VotingUserData.fromJson(Map<String, dynamic> json) {
    return VotingUserData(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      username: json['username'] as String,
      pictureUrl: json['picture_url'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'picture_url': pictureUrl,
      };
}

