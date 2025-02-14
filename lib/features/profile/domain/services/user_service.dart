import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:socialverse/export.dart';

class ProfileService {
  final Dio dio;
  final DioCacheManager cacheManager;

  ProfileService({Dio? dioInstance, DioCacheManager? cacheManagerInstance})
      : dio = dioInstance ?? Dio(BaseOptions(baseUrl: API.endpoint)),
        cacheManager = cacheManagerInstance ?? DioCacheManager(CacheConfig());

  Future<Response?> getUserProfile({required String username, bool forceRefresh = false}) async {
    return _handleRequest(
      () => dio.get(
        '${API.profile}/$username',
        options: buildCacheOptions(
          const Duration(days: 1),
          forceRefresh: forceRefresh,
          options: _authHeaders(),
        ),
      ),
    );
  }

  Future<Response?> getPosts(String username, int page) async {
    return _handleRequest(
      () => dio.get(
        'users/$username/posts?page=$page',
        options: buildCacheOptions(
          const Duration(days: 1),
          options: _authHeaders(),
        ),
      ),
    );
  }

  Future<Response?> getLikedPosts() async {
    return _handleRequest(
      () => dio.get(
        '${API.posts}/liked',
        options: _authHeaders(),
      ),
    );
  }

  Future<int?> userFollow(String username) => _postRequest('${API.follow}/$username');
  Future<int?> userUnfollow(String username) => _postRequest('${API.unfollow}/$username');
  Future<int?> blockUser(String username) => _postRequest('${API.block}/$username');
  Future<int?> unblockUser(String username) => _postRequest('${API.unblock}/$username');

  Future<Response?> getActiveUsers() async {
    return _handleRequest(
      () => dio.get(
        '${API.active}?page=1',
        options: _authHeaders(),
      ),
    );
  }

  Future<dynamic> getFollowing(String username) async {
    return _handleRequest(
      () => dio.get(
        '${API.following}/$username',
        options: _authHeaders(),
      ),
    );
  }

  Future<dynamic> getFollowers(String username) async {
    return _handleRequest(
      () => dio.get(
        '${API.followers}/$username',
        options: _authHeaders(),
      ),
    );
  }

  /// Helper method for handling GET requests
  Future<Response?> _handleRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      _handleDioError(e);
      return null;
    }
  }

  /// Helper method for handling POST requests
  Future<int?> _postRequest(String path) async {
    return _handleRequest(
      () async {
        final response = await dio.post(path, options: _authHeaders());
        return response.statusCode;
      },
    );
  }

  /// Adds authentication headers
  Options _authHeaders() {
    final token = prefs?.getString('token') ?? '';
    return Options(headers: {'Flic-Token': token});
  }

  /// Handles Dio errors in a structured way
  void _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final errorMessage = e.response?.data ?? e.message;
    log('API Error: $statusCode - $errorMessage');
  }
}

