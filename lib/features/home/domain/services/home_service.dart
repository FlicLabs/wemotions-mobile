import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class HomeService {
  final Dio _dio = Dio(BaseOptions(followRedirects: false));

  Map<String, String> _getHeaders() {
    return {'Flic-Token': token ?? ''};
  }

  Future<dynamic> _handleRequest(Future<Response> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioException catch (e) {
      print("Error: ${e.response?.statusCode} - ${e.response?.statusMessage}");
      return e.response?.statusCode ?? 500;
    }
  }

  Future<dynamic> getFeed(int page) async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}${API.feed}?page=$page',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> getSinglePost({required int id}) async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}${API.posts}/$id',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> postLikeAdd(int id) async {
    return _handleRequest(() => _dio.post(
          '${API.endpoint}${API.posts}/$id/upvote',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> postLikeRemove(int id) async {
    return _handleRequest(() => _dio.delete(
          '${API.endpoint}${API.posts}/$id/upvote',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> blockPost(int id) async {
    return _handleRequest(() => _dio.post(
          '${API.endpoint}${API.posts}/$id/block',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> unblockPost(int id) async {
    return _handleRequest(() => _dio.post(
          '${API.endpoint}${API.posts}/$id/unblock',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<int> deletePost(int id) async {
    return await _handleRequest(() => _dio.delete(
          '${API.endpoint}${API.posts}/$id',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<int> deletePostAdmin(int id) async {
    return await _handleRequest(() => _dio.delete(
          '${API.endpoint}${API.posts}/$id?api_key=',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> getReplies(int id) async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}${API.posts}/$id/replies',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> getVotings() async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}get/votings',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> addVoting({required Map<String, dynamic> data}) async {
    return _handleRequest(() => _dio.post(
          '${API.endpoint}${API.posts}/add/votings',
          data: data,
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> removeVoting({required Map<String, dynamic> data}) async {
    return _handleRequest(() => _dio.delete(
          '${API.endpoint}${API.posts}/remove/votings',
          data: data,
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> updateVoting(int postId) async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}${API.posts}/$postId',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> searchUserForTagging(String query) async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}search?type=user&query=$query',
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> tagUser({required Map<String, dynamic> data}) async {
    return _handleRequest(() => _dio.post(
          '${API.endpoint}${API.posts}/tag',
          data: data,
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> removeTag({required Map<String, dynamic> data}) async {
    return _handleRequest(() => _dio.delete(
          '${API.endpoint}${API.posts}/remove/tag',
          data: data,
          options: Options(headers: _getHeaders()),
        ));
  }

  Future<dynamic> updateTags(int postId) async {
    return _handleRequest(() => _dio.get(
          '${API.endpoint}${API.posts}/$postId',
          options: Options(headers: _getHeaders()),
        ));
  }
}

