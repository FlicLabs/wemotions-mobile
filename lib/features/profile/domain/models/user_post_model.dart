import 'package:socialverse/features/search/domain/models/search/subverse_search_model.dart';

class UserPostModel {
  UserPostModel({
    required this.id,
    required this.category,
    required this.slug,
    required this.title,
    required this.identifier,
    required this.commentCount,
    required this.upvoteCount,
    required this.viewCount,
    required this.exitCount,
    required this.ratingCount,
    required this.averageRating,
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
  });
  late final int id;
  late final SubverseSearchModel category;
  late final String slug;
  late final String title;
  late final String identifier;
  late int commentCount;
  late int upvoteCount;
  late int viewCount;
  late int exitCount;
  late int ratingCount;
  late int averageRating;
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
  late final bool following;
  late final String pictureUrl;

  UserPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = SubverseSearchModel.fromJson(json['category'] ?? {});
    slug = json['slug'] ?? '';
    title = json['title'] ?? '';
    identifier = json['identifier'] ?? '';
    commentCount = json['comment_count'] ?? 0;
    upvoteCount = json['upvote_count'] ?? 0;
    viewCount = json['view_count'] ?? 0;
    exitCount = json['exit_count'] ?? 0;
    ratingCount = json['rating_count'] ?? 0;
    averageRating = json['average_rating'] ?? 0;
    shareCount = json['share_count'] ?? 0;
    videoLink = json['video_link'] ?? '';
    isLocked = json['is_locked'] ?? false;
    createdAt = json['created_at'] ?? 0;
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    username = json['username'] ?? '';
    upvoted = json['upvoted'] ?? false;
    bookmarked = json['bookmarked'] ?? false;
    thumbnailUrl = json['thumbnail_url'] ?? '';
    following = json['following'] ?? false;
    pictureUrl = json['picture_url'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category'] = category.toJson();
    _data['slug'] = slug;
    _data['title'] = title;
    _data['identifier'] = identifier;
    _data['comment_count'] = commentCount;
    _data['upvote_count'] = upvoteCount;
    _data['view_count'] = viewCount;
    _data['exit_count'] = exitCount;
    _data['rating_count'] = ratingCount;
    _data['average_rating'] = averageRating;
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
    return _data;
  }
}
