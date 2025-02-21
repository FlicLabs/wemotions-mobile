import 'package:socialverse/export.dart';

class PostSearchModel {
  PostSearchModel({
    required this.id,
    this.category,
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

  final int id;
  final Category? category; // Made nullable
  final String slug;
  final String title;
  final String identifier;
  int commentCount;
  int upvoteCount;
  int viewCount;
  int exitCount;
  int ratingCount;
  int averageRating;
  int shareCount;
  final String videoLink;
  final bool isLocked;
  final int createdAt;
  final String firstName;
  final String lastName;
  final String username;
  bool upvoted;
  final bool bookmarked;
  final String thumbnailUrl;
  bool following;
  final String pictureUrl;

  factory PostSearchModel.fromJson(Map<String, dynamic> json) {
    return PostSearchModel(
      id: json['id'] ?? 0,
      category: (json['category'] != null && json['category'] is Map<String, dynamic>)
          ? Category.fromJson(json['category'])
          : null, // Handle null category properly
      slug: json['slug'] ?? '',
      title: json['title'] ?? '',
      identifier: json['identifier'] ?? '',
      commentCount: json['comment_count'] ?? 0,
      upvoteCount: json['upvote_count'] ?? 0,
      viewCount: json['view_count'] ?? 0,
      exitCount: json['exit_count'] ?? 0,
      ratingCount: json['rating_count'] ?? 0,
      averageRating: json['average_rating'] ?? 0,
      shareCount: json['share_count'] ?? 0,
      videoLink: json['video_link'] ?? '',
      isLocked: json['is_locked'] ?? false,
      createdAt: json['created_at'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      username: json['username'] ?? '',
      upvoted: json['upvoted'] ?? false,
      bookmarked: json['bookmarked'] ?? false,
      thumbnailUrl: json['thumbnail_url'] ?? '',
      following: json['following'] ?? false,
      pictureUrl: json['picture_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category?.toJson(), // Handle nullable category
      'slug': slug,
      'title': title,
      'identifier': identifier,
      'comment_count': commentCount,
      'upvote_count': upvoteCount,
      'view_count': viewCount,
      'exit_count': exitCount,
      'rating_count': ratingCount,
      'average_rating': averageRating,
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
    };
  }
}
