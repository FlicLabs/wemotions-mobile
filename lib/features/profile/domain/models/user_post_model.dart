import 'package:equatable/equatable.dart';
import 'package:socialverse/features/search/domain/models/search/subverse_search_model.dart';

class UserPostModel extends Equatable {
  final int id;
  final SubverseSearchModel category;
  final String slug;
  final String title;
  final String identifier;
  final int commentCount;
  final int upvoteCount;
  final int viewCount;
  final int exitCount;
  final int ratingCount;
  final int averageRating;
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

  const UserPostModel({
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

  /// Default empty instance
  static const empty = UserPostModel(
    id: 0,
    category: SubverseSearchModel.empty,
    slug: '',
    title: '',
    identifier: '',
    commentCount: 0,
    upvoteCount: 0,
    viewCount: 0,
    exitCount: 0,
    ratingCount: 0,
    averageRating: 0,
    shareCount: 0,
    videoLink: '',
    isLocked: false,
    createdAt: 0,
    firstName: '',
    lastName: '',
    username: '',
    upvoted: false,
    bookmarked: false,
    thumbnailUrl: '',
    following: false,
    pictureUrl: '',
  );

  /// Factory constructor for safer JSON parsing
  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      id: json['id'] ?? 0,
      category: SubverseSearchModel.fromJson(json['category'] ?? {}),
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

  /// Converts the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.toJson(),
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

  /// Allows partial updates without recreating the whole object
  UserPostModel copyWith({
    int? id,
    SubverseSearchModel? category,
    String? slug,
    String? title,
    String? identifier,
    int? commentCount,
    int? upvoteCount,
    int? viewCount,
    int? exitCount,
    int? ratingCount,
    int? averageRating,
    int? shareCount,
    String? videoLink,
    bool? isLocked,
    int? createdAt,
    String? firstName,
    String? lastName,
    String? username,
    bool? upvoted,
    bool? bookmarked,
    String? thumbnailUrl,
    bool? following,
    String? pictureUrl,
  }) {
    return UserPostModel(
      id: id ?? this.id,
      category: category ?? this.category,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      identifier: identifier ?? this.identifier,
      commentCount: commentCount ?? this.commentCount,
      upvoteCount: upvoteCount ?? this.upvoteCount,
      viewCount: viewCount ?? this.viewCount,
      exitCount: exitCount ?? this.exitCount,
      ratingCount: ratingCount ?? this.ratingCount,
      averageRating: averageRating ?? this.averageRating,
      shareCount: shareCount ?? this.shareCount,
      videoLink: videoLink ?? this.videoLink,
      isLocked: isLocked ?? this.isLocked,
      createdAt: createdAt ?? this.createdAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      upvoted: upvoted ?? this.upvoted,
      bookmarked: bookmarked ?? this.bookmarked,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      following: following ?? this.following,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  @override
  List<Object> get props => [
        id,
        category,
        slug,
        title,
        identifier,
        commentCount,
        upvoteCount,
        viewCount,
        exitCount,
        ratingCount,
        averageRating,
        shareCount,
        videoLink,
        isLocked,
        createdAt,
        firstName,
        lastName,
        username,
        upvoted,
        bookmarked,
        thumbnailUrl,
        following,
        pictureUrl,
      ];
}
