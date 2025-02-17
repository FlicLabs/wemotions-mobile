import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class InviteService {
  final Dio dio;

  InviteService({Dio? dioInstance})
      : dio = dioInstance ?? Dio(BaseOptions(baseUrl: API.endpoint));

  Future<Response> getActiveUsers({int page = 1}) async {
    final token = prefs?.getString('token') ?? '';

    try {
      final response = await dio.get(
        '${API.active}?page=$page',
        options: _authHeaders(token),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<int?> userFollow(String username) async {
    return _postRequest('${API.follow}/$username');
  }

  Future<int?> userUnfollow(String username) async {
    return _postRequest('${API.unfollow}/$username');
  }

  /// Reusable method for follow/unfollow requests
  Future<int?> _postRequest(String endpoint) async {
    final token = prefs?.getString('token') ?? '';

    try {
      final response = await dio.post(
        endpoint,
        options: _authHeaders(token),
      );
      return response.statusCode;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Adds authentication headers
  Options _authHeaders(String token) {
    return Options(headers: {'Flic-Token': token});
  }

  /// Handles Dio errors in a structured way
  Exception _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final errorMessage = e.response?.data ?? e.message;

    log('API Error: $statusCode - $errorMessage');
    return Exception('API Error: $statusCode - $errorMessage');
  }
}

