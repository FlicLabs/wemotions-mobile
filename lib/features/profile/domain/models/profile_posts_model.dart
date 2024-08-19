import 'package:socialverse/core/domain/models/post_model.dart';

class ProfilePostsModel {
  ProfilePostsModel({
    required this.page,
    required this.recordsPerPage,
    required this.maxPageSize,
    required this.pageSize,
    required this.posts,
  });
  late final String page;
  late final int recordsPerPage;
  late final int maxPageSize;
  late final int pageSize;
  late final List<Posts> posts;
  
  ProfilePostsModel.fromJson(Map<String, dynamic> json){
    page = json['page'];
    recordsPerPage = json['records_per_page'];
    maxPageSize = json['max_page_size'];
    pageSize = json['page_size'];
    posts = List.from(json['posts']).map((e)=>Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['records_per_page'] = recordsPerPage;
    _data['max_page_size'] = maxPageSize;
    _data['page_size'] = pageSize;
    _data['posts'] = posts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

