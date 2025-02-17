import 'package:equatable/equatable.dart';
import 'package:socialverse/core/domain/models/post_model.dart';

class ProfilePostsModel extends Equatable {
  final String page;
  final int recordsPerPage;
  final int maxPageSize;
  final int pageSize;
  final List<Posts> posts;

  const ProfilePostsModel({
    required this.page,
    required this.recordsPerPage,
    required this.maxPageSize,
    required this.pageSize,
    required this.posts,
  });

  /// Default empty instance
  static const empty = ProfilePostsModel(
    page: '',
    recordsPerPage: 0,
    maxPageSize: 0,
    pageSize: 0,
    posts: [],
  );

  /// Factory constructor for safer JSON parsing
  factory ProfilePostsModel.fromJson(Map<String, dynamic> json) {
    return ProfilePostsModel(
      page: json['page'] ?? '',
      recordsPerPage: json['records_per_page'] ?? 0,
      maxPageSize: json['max_page_size'] ?? 0,
      pageSize: json['page_size'] ?? 0,
      posts: (json['posts'] as List<dynamic>?)
              ?.map((e) => Posts.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converts the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'records_per_page': recordsPerPage,
      'max_page_size': maxPageSize,
      'page_size': pageSize,
      'posts': posts.map((e) => e.toJson()).toList(),
    };
  }

  /// Allows partial updates without recreating the whole object
  ProfilePostsModel copyWith({
    String? page,
    int? recordsPerPage,
    int? maxPageSize,
    int? pageSize,
    List<Posts>? posts,
  }) {
    return ProfilePostsModel(
      page: page ?? this.page,
      recordsPerPage: recordsPerPage ?? this.recordsPerPage,
      maxPageSize: maxPageSize ?? this.maxPageSize,
      pageSize: pageSize ?? this.pageSize,
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [page, recordsPerPage, maxPageSize, pageSize, posts];
}
