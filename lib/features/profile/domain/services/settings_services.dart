import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class SettingsService {
  final Dio dio;

  SettingsService({Dio? dioInstance})
      : dio = dioInstance ?? Dio(BaseOptions(baseUrl: API.endpoint));

  Future<int?> deleteAccount() async {
    final token = prefs?.getString('token') ?? '';

    try {
      final response = await dio.delete(
        API.user,
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
