import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:socialverse/export.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class SubverseService {
  final Dio _dio = Dio();

  Options getHeaders() {
    return Options(headers: {'Flic-Token': token ?? ''});
  }

  Future<Response?> getSpheres({required int page, bool forceRefresh = false}) async {
    final String url = '${API.endpoint}${API.categories}?page=$page';
    debugPrint('Fetching spheres: $url');

    try {
      Response response = await _dio.get(
        url,
        options: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: forceRefresh,
          options: getHeaders(),
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (getSpheres): ${e.message}');
      return null;
    }
  }

  Future<Response?> getSubversePosts({required int page}) async {
    final String url = '${API.endpoint}${API.all_posts}?sort=REPLY_COUNT&page=$page';
    debugPrint('Fetching subverse posts: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (getSubversePosts): ${e.message}');
      return null;
    }
  }

  Future<Response?> getPostsByExitCount({required int id, required int page}) async {
    final String url = '${API.endpoint}${API.all_posts}?sort=ONLINE_USER&page=$page';
    debugPrint('Fetching posts by exit count: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (getPostsByExitCount): ${e.message}');
      return null;
    }
  }

  Future<Response?> getPostsByViewCount({required int id, required int page}) async {
    final String url = '${API.endpoint}${API.subverse}/$id/posts/viewCount?page=$page';
    debugPrint('Fetching posts by view count: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (getPostsByViewCount): ${e.message}');
      return null;
    }
  }

  Future<Response?> getSubverseInfo({required int id}) async {
    final String url = '${API.endpoint}${API.categories}/$id';
    debugPrint('Fetching subverse info: $url');

    try {
      Response response = await _dio.get(
        url,
        options: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: true,
          options: getHeaders(),
        ),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (getSubverseInfo): ${e.message}');
      return null;
    }
  }

  Future<Response?> search({required String query, required String type}) async {
    final String url = '${API.endpoint}${API.search}?type=$type&query=$query';
    debugPrint('Performing search: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (search): ${e.message}');
      return null;
    }
  }
}
