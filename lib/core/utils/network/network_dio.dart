import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialverse/core/widgets/progress_indicator.dart';
import 'internet_error.dart';

class NetworkDio {
  static Dio? _dio;
  static String? endPointUrl;
  static Options? _cacheOptions;
  static DioCacheManager? _dioCacheManager;
  static Circle processIndicator = Circle();
  NetworkCheck networkCheck = NetworkCheck();
  static InternetError internetError = InternetError();

  /// Fetch headers, ensuring null safety
  static Future<Map<String, String>> getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    debugPrint('SET HEADER : $token');

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'authorization': token,
    };
  }

  /// Initializes Dio with headers
  static Future<void> setDynamicHeader({required String? endPoint}) async {
    endPointUrl = endPoint;
    BaseOptions options = BaseOptions(
      receiveTimeout: Duration(milliseconds: 50000),
      connectTimeout: Duration(milliseconds: 50000),
    );
    _dioCacheManager = DioCacheManager(CacheConfig());
    final headers = await getHeaders();
    options.headers.addAll(headers);
    _dio = Dio(options);
    _dio?.interceptors.add(_dioCacheManager!.interceptor);
  }

  /// Checks for internet connection before proceeding
  static Future<bool> check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Generic GET request
  static Future<Map<String, dynamic>> getDioHttpMethod({
    BuildContext? context,
    required String url,
    Options? header,
    bool loader = false,
  }) async {
    if (!await check()) {
      internetError.addOverlayEntry(context);
      return _errorResponse("Internet Error");
    }

    if (_dio == null) {
      return _errorResponse("Dio is not initialized");
    }

    if (loader && context != null) processIndicator.show(context);

    try {
      debugPrint("GET: $url");
      Response response = await _dio!.get(
        url,
        options: header ?? _cacheOptions,
      );

      if (loader && context != null) processIndicator.hide(context);

      return _parseResponse(response);
    } on DioException catch (error) {
      if (loader && context != null) processIndicator.hide(context);
      return await _handleDioError(error, context);
    }
  }

  /// Generic POST request
  static Future<Map<String, dynamic>> postDioHttpMethod({
    BuildContext? context,
    required String url,
    dynamic data,
    Options? header,
  }) async {
    if (!await check()) {
      internetError.addOverlayEntry(context);
      return _errorResponse("Bad Internet Connection");
    }

    if (_dio == null) {
      return _errorResponse("Dio is not initialized");
    }

    try {
      debugPrint("POST: $url");
      Response response = await _dio!.post(
        url,
        data: data,
        options: header ?? _cacheOptions,
      );

      return _parseResponse(response);
    } on DioException catch (error) {
      return await _handleDioError(error, context);
    }
  }

  /// Generic PUT request
  static Future<Map<String, dynamic>> putDioHttpMethod({
    BuildContext? context,
    required String url,
    dynamic data,
    Options? header,
  }) async {
    if (!await check()) {
      internetError.addOverlayEntry(context);
      return _errorResponse("Check your internet connection");
    }

    if (_dio == null) {
      return _errorResponse("Dio is not initialized");
    }

    if (context != null) processIndicator.show(context);

    try {
      Response response = await _dio!.put(
        url,
        data: data,
        options: header ?? _cacheOptions,
      );

      if (context != null) processIndicator.hide(context);

      return _parseResponse(response);
    } on DioException catch (error) {
      if (context != null) processIndicator.hide(context);
      return await _handleDioError(error, context);
    }
  }

  /// Handles Dio errors safely
  static Future<Map<String, dynamic>> _handleDioError(
      DioException error, BuildContext? context) async {
    log(error.toString());

    String errorMessage = await _parseDioError(error, context);
    return _errorResponse(errorMessage);
  }

  /// Parses Dio response safely
  static Map<String, dynamic> _parseResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic responseBody;
      try {
        responseBody = json.decode(json.encode(response.data));
      } catch (error) {
        debugPrint('Decoding error');
        responseBody = response.data;
      }
      return {
        'body': responseBody,
        'headers': response.headers.map,
        'error_description': null,
      };
    }
    return _errorResponse("Something Went Wrong");
  }

  /// Parses Dio error types safely
  static Future<String> _parseDioError(DioException error, BuildContext? context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            return "Connection timeout with API server";
          case DioExceptionType.sendTimeout:
            return "Send timeout in connection with API server";
          case DioExceptionType.receiveTimeout:
            return "Receive timeout in connection with API server";
          case DioExceptionType.badResponse:
            return error.response?.data['message'] ?? "Unexpected server response";
          case DioExceptionType.cancel:
            return "Request to API server was cancelled";
          case DioExceptionType.connectionError:
            return "Failed to connect to API server";
          default:
            return "Unexpected error occurred";
        }
      }
    } on SocketException catch (_) {
      return "Please check your internet connection";
    }
    return "An unknown error occurred";
  }

  /// Standardized error response
  static Map<String, dynamic> _errorResponse(String message) {
    return {
      'body': null,
      'headers': null,
      'error_description': message,
    };
  }
}
