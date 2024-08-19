import 'package:socialverse/export.dart';

class FeedModel {
  FeedModel({
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.posts,
  });
  late final String page;
  // late final int recordsPerPage;
  late final int maxPageSize;
  late final int pageSize;
  late final List<Posts> posts;

  FeedModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['page_size'];
    posts = List.from(json['posts']).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['max_page_size'] = maxPageSize;
    _data['page_size'] = pageSize;
    _data['posts'] = posts.map((e) => e.toJson()).toList();
    return _data;
  }
}
