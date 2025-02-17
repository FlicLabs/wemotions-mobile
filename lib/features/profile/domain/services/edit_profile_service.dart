import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class EditProfileService {
  final Dio dio;

  EditProfileService({Dio? dioInstance})
      : dio = dioInstance ?? Dio(BaseOptions(baseUrl: API.endpoint));

  Future<int?> updateProfile(Map<String, dynamic> data) async {
    final token = prefs?.getString('token') ?? '';

    try {
      final response = await dio.put(
        API.updateProfile,
        data: data,
        options: _authHeaders(token),
      );
      return response.statusCode;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<int?> uploadImage(dynamic data) async {
    final token = prefs?.getString('token') ?? '';

    try {
      final response = await dio.post(
        '${API.user}/picture/upload',
        data: data,
        options: _authHeaders(token),
      );
      return response.statusCode;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> updateUsername(Map<String, dynamic> data) async {
    final token = prefs?.getString('token') ?? '';

    try {
      final response = await dio.post(
        API.updateUsername,
        data: data,
        options: _authHeaders(token),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> getUsername({required String username}) async {
    try {
      final response = await dio.get('${API.profile}/$username');
      return response;
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
