import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class CommentService {
  Dio dio = Dio();

  Future<dynamic> getComments(int id) async {
    print('${API.endpoint}${API.posts}/$id/comments');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.posts}/$id/comments',
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );
      // print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      return e.response;
    }
  }

  Future<dynamic> addComment({
    required int post_id,
    required Map data,
  }) async {
    print('${API.endpoint}${API.posts}/$post_id/comments');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.posts}/$post_id/comments',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      return e.response?.data;
    }
  }

  Future<int?> upvoteComment(int comment_id) async {
    print('${API.endpoint}${API.comments}/$comment_id/upvote');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.comments}/$comment_id/upvote',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.statusCode);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      return e.response?.statusCode;
    }
  }

  Future<int?> removeUpvoteComment(int comment_id) async {
    print('${API.endpoint}${API.comments}/$comment_id/upvote');
    try {
      Response response = await dio.delete(
        '${API.endpoint}${API.comments}/$comment_id/upvote',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.statusCode);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      return e.response?.statusCode;
    }
  }
}
