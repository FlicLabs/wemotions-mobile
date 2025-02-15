import 'package:socialverse/export.dart';

class FeedModel {
  FeedModel({
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.posts,
  });

  final int page;
  final int maxPageSize;
  final int pageSize;
  final List<Posts> posts;

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      page: json['page'] as int,
      maxPageSize: json['max_page_size'] as int,
      pageSize: json['page_size'] as int,
      posts: (json['posts'] as List<dynamic>).map((e) => Posts.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'max_page_size': maxPageSize,
        'page_size': pageSize,
        'posts': posts.map((e) => e.toJson()).toList(),
      };
}

class ReplyModel {
  ReplyModel({
    required this.status,
    required this.message,
    required this.post,
  });

  final String status;
  final String message;
  final List<Posts> post;

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    return ReplyModel(
      status: json['status'] as String,
      message: json['message'] as String,
      post: (json['post'] as List<dynamic>).map((e) => Posts.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'post': post.map((e) => e.toJson()).toList(),
      };
}

