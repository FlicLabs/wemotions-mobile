class Posts {
  Posts({
    required this.id,
    // required this.category,
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
    required this.voting_count,
    required this.votings,
    required this.tags,
    required this.childVideoCount,
  });

  late int id;
  // late final Category category;
  late final String slug;
  late final String title;
  late final String identifier;
  late int commentCount;
  late int upvoteCount;
  late int viewCount;
  late int shareCount;
  late final String videoLink;
  late final bool isLocked;
  late final int createdAt;
  late final String firstName;
  late final String lastName;
  late final String username;
  late bool upvoted;
  late final bool bookmarked;
  late final String thumbnailUrl;
  late bool following;
  late final String pictureUrl;
  late int voting_count;
  late List<Votings> votings;
  late List<Tags> tags;
  late int childVideoCount;

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // category = Category.fromJson(json['category']);
    slug = json['slug'];
    title = json['title'];
    identifier = json['identifier'];
    commentCount = json['comment_count'];
    upvoteCount = json['upvote_count'];
    viewCount = json['view_count'];
    shareCount = json['share_count'];
    videoLink = json['video_link'];
    isLocked = json['is_locked'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    upvoted = json['upvoted'];
    bookmarked = json['bookmarked'];
    thumbnailUrl = json['thumbnail_url'];
    following = json['following'];
    pictureUrl = json['picture_url'];
    voting_count = json['voting_count'];
    votings =
        List.from(json['votings']).map((e) => Votings.fromJson(e)).toList();
    tags = List.from(json['tags']).map((e) => Tags.fromJson(e)).toList();
    childVideoCount = json['child_video_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    // _data['category'] = category.toJson();
    _data['slug'] = slug;
    _data['title'] = title;
    _data['identifier'] = identifier;
    _data['comment_count'] = commentCount;
    _data['upvote_count'] = upvoteCount;
    _data['view_count'] = viewCount;
    _data['share_count'] = shareCount;
    _data['video_link'] = videoLink;
    _data['is_locked'] = isLocked;
    _data['created_at'] = createdAt;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['upvoted'] = upvoted;
    _data['bookmarked'] = bookmarked;
    _data['thumbnail_url'] = thumbnailUrl;
    _data['following'] = following;
    _data['picture_url'] = pictureUrl;
    _data['voting_count'] = voting_count;
    _data['votings'] = votings.map((e) => e.toJson()).toList();
    _data['tags'] = tags.map((e) => e.toJson()).toList();
    _data['child_video_count'] = childVideoCount;
    return _data;
  }
}

class Votings {
  Votings({
    required this.id,
    required this.votingIcon,
    required this.user,
    required this.createdAt,
  });
  late final int id;
  late final String votingIcon;
  late final VotingUserData user;
  late final String createdAt;

  Votings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    votingIcon = json['voting_icon'];
    user = VotingUserData.fromJson(json['user']);
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['voting_icon'] = votingIcon;
    _data['user'] = user.toJson();
    _data['created_at'] = createdAt;
    return _data;
  }
}

class Tags {
  Tags({
    required this.id,
    required this.user,
    required this.createdAt,
  });
  late final int id;
  late final VotingUserData user;
  late final String createdAt;

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = VotingUserData.fromJson(json['user']);
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user'] = user.toJson();
    _data['created_at'] = createdAt;
    return _data;
  }
}

class VotingUserData {
  VotingUserData({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.pictureUrl,
  });
  late final String firstName;
  late final String lastName;
  late final String username;
  late final String pictureUrl;

  VotingUserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    pictureUrl = json['picture_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['username'] = username;
    _data['picture_url'] = pictureUrl;
    return _data;
  }
}
