import 'package:socialverse/export.dart';

class SinglePostModel {
  SinglePostModel({
    required this.status,
    required this.post,
  });
  late final String status;
  late final List<Posts> post;

  SinglePostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    post = List.from(json['post']).map((e) => Posts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['post'] = post.map((e) => e.toJson()).toList();
    return _data;
  }
}
