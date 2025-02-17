import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String instagramUrl;
  final String tiktokUrl;
  final String youtubeUrl;
  final String website;
  final bool isOnline;
  final String firstName;
  final String lastName;
  final String name;
  final String bio;
  final String profilePictureUrl;
  final String username;
  final int followerCount;
  final int followingCount;
  final int postCount;
  final bool isFollowing;
  final bool isBlocked;
  final int? chatId;

  const ProfileModel({
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

  static const empty = ProfileModel(
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      instagramUrl: json['instagram_url'] ?? '',
      tiktokUrl: json['tiktok_url'] ?? '',
      youtubeUrl: json['youtube_url'] ?? '',
      website: json['website'] ?? '',
      isOnline: json['is_online'] ?? false,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      name: json['name'] ?? '',
      bio: json['bio'] ?? '',
      profilePictureUrl: json['profile_picture_url'] ?? '',
      username: json['username'] ?? '',
      followerCount: (json['follower_count'] ?? 0) as int,
      followingCount: (json['following_count'] ?? 0) as int,
      postCount: (json['post_count'] ?? 0) as int,
      isFollowing: json['is_following'] ?? false,
      isBlocked: json['is_blocked'] ?? false,
      chatId: json['chat_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagram_url': instagramUrl,
      'tiktok_url': tiktokUrl,
      'youtube_url': youtubeUrl,
      'website': website,
      'is_online': isOnline,
      'first_name': firstName
