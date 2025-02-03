class ProfileModel {
  ProfileModel({
    required this.instagramUrl,
    required this.tiktokUrl,
    required this.youtubeUrl,
    required this.website,
    required this.isOnline,
    required this.firstName,
    required this.lastName,
    required this.name,
    required this.bio,
    required this.profilePictureUrl,
    required this.username,
    required this.followerCount,
    required this.followingCount,
    required this.postCount,
    required this.isFollowing,
    required this.isBlocked,
    this.chatId,
  });

  late final String instagramUrl;
  late final String tiktokUrl;
  late final String youtubeUrl;
  late final String website;
  late final bool isOnline;
  late final String firstName;
  late final String lastName;
  late final String name;
  late final String bio;
  late final String profilePictureUrl;
  late String username;
  late final int followerCount;
  late final int followingCount;
  late final int postCount;
  late bool isFollowing;
  late bool isBlocked;
  late final int? chatId;


  static var empty = ProfileModel(
    instagramUrl: '',
    tiktokUrl: '',
    youtubeUrl: '',
    website: '',
    isOnline: false,
    firstName: '',
    lastName: '',
    name: '',
    bio: '',
    profilePictureUrl: '',
    username: '',
    followerCount: 0,
    followingCount: 0,
    postCount: 0,
    isFollowing: false,
    isBlocked: false,
    chatId: null,
  );

  ProfileModel.fromJson(Map<String, dynamic> json) {
    instagramUrl = json['instagram_url'];
    tiktokUrl = json['tiktok_url'];
    youtubeUrl = json['youtube_url'];
    website = json['website'];
    isOnline = json['is_online'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    name = json['name'];
    bio = json['bio'];
    profilePictureUrl = json['profile_picture_url'];
    username = json['username'];
    followerCount = json['follower_count'];
    followingCount = json['following_count'];
    postCount = json['post_count'];
    isFollowing = json['is_following'] ?? false;
    isBlocked = json['is_blocked'] ?? false;
    chatId = json['chat_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['instagram_url'] = instagramUrl;
    _data['tiktok_url'] = tiktokUrl;
    _data['youtube_url'] = youtubeUrl;
    _data['website'] = website;
    _data['is_online'] = isOnline;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['name'] = name;
    _data['bio'] = bio;
    _data['profile_picture_url'] = profilePictureUrl;
    _data['username'] = username;
    _data['follower_count'] = followerCount;
    _data['following_count'] = followingCount;
    _data['post_count'] = postCount;
    _data['is_following'] = isFollowing;
    _data['is_blocked'] = isBlocked;
    _data['chat_id'] = chatId;
    return _data;
  }
}
