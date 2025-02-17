import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:socialverse/export.dart';

class AuthService {
  final Dio dio;

  AuthService({Dio? dio}) : dio = dio ?? Dio(); // Inject Dio for testability

  Future<Response> login(Map<String, dynamic> data) async {
    return _handleRequest(
      () => dio.post('${API.endpoint}${API.login}', data: data),
    );
  }

  Future<Response> signUp(Map<String, dynamic> data) async {
    return _handleRequest(
      () => dio.post('${API.endpoint}${API.signup}', data: data),
    );
  }

  Future<Response> oauth(Map<String, dynamic> data) async {
    return _handleRequest(
      () => dio.post('${API.endpoint}${API.oauth}', data: data),
    );
  }

  Future<Response> reset(Map<String, dynamic> data) async {
    return _handleRequest(
      () => dio.post('${API.endpoint}${API.reset}', data: data),
    );
  }

  /// Handles API requests with proper error handling
  Future<Response> _handleRequest(Future<Response> Function() request) async {
    try {
      final Response response = await request();
      if (kDebugMode) {
        debugPrint('Response: ${response.data}');
      }
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 500;
      final message = e.response?.statusMessage ?? 'Unknown error';

      debugPrint('Error $statusCode: $message');

      throw AuthException(statusCode, message);
    }
  }
}

/// Custom Exception for Authentication Errors
class AuthException implements Exception {
  final int statusCode;
  final String message;

  AuthException(this.statusCode, this.message);

  @override
  String toString() => 'AuthException ($statusCode): $message';
}
