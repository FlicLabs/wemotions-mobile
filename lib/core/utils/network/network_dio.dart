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
  NetworkCheck networkCheck = new NetworkCheck();
  static InternetError internetError = new InternetError();

  static Future<Map<String, String>> getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      debugPrint('SET HEADER : $token');
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization': token,
      };
    } else {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static setDynamicHeader({required String? endPoint}) async {
    endPointUrl = endPoint;
    BaseOptions options = BaseOptions(
      receiveTimeout: 50000,
      connectTimeout: 50000,
    );
    _dioCacheManager = DioCacheManager(CacheConfig());
    final token = await getHeaders();
    options.headers.addAll(token);
    _dio = Dio(options);
    _dio!.interceptors.add(_dioCacheManager!.interceptor);
  }

  // Get Method
  static Future<Map<String, dynamic>> getDioHttpMethod({
    BuildContext? context,
    required String url,
    Options? header,
    bool? loader = false,
  }) async {
    var internet = await check();
    if (internet) {
      if (loader == true) {
        if (context != null) processIndicator.show(context);
      }
      try {
        debugPrint(url);
        Response response = await _dio!.get(
          url,
          options: header ?? _cacheOptions,
        );
        var responseBody;
        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            debugPrint(error.toString());
            responseBody = response.data;
          }
          Map<String, dynamic> data = {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
          if (loader == true) {
            if (context != null) processIndicator.hide(context);
          }
          return data;
        } else {
          if (loader == true) {
            if (context != null) processIndicator.hide(context);
          }
          return {
            'body': null,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } on DioError catch (error) {
        if (error.response?.statusCode == 500) {
          if (loader == true) {
            if (context != null) processIndicator.hide(context);
          }
          return {
            'body': null,
            'headers': null,
            'error_description': "Internal Server Error [500]",
          };
        } else {
          Map<String, dynamic> responseData = {
            'body': null,
            'headers': null,
            'error_description': await _handleError(error, context,
                message: error.response?.data['message']),
          };
          if (loader == true) {
            if (context != null) processIndicator.hide(context);
          }
          return responseData;
        }
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry(context);
      return responseData;
    }
  }

  // Put Method
  static Future<Map<String, dynamic>> putDioHttpMethod({
    BuildContext? context,
    final header,
    required String url,
    required data,
  }) async {
    var internet = await check();
    if (internet) {
      if (context != null) processIndicator.show(context);
      try {
        Response response = await _dio!.put(
          url,
          data: data,
          options: header ?? _cacheOptions,
        );
        // ignore: prefer_typing_uninitialized_variables
        var responseBody;
        if (response.statusCode == 200) {
          if (context != null) processIndicator.hide(context);
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            responseBody = response.data;
            debugPrint('catch...');
          }
          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else {
          if (context != null) processIndicator.hide(context);
          return {
            'body': null,
            'headers': null,
            'error_description': "Something went wrong",
          };
        }
      } on DioError catch (error) {
        log(error.toString());

        Map<String, dynamic> responseData = {
          'body': null,
          'headers': null,
          'error_description': await _handleError(
            error,
            context,
            message: error.response?.data['message'],
          ),
        };
        if (context != null) processIndicator.hide(context);
        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Check your internet connection",
      };
      internetError.addOverlayEntry(context);
      return responseData;
    }
  }

  static Future<bool> check() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   return true;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   return true;
    // }
    return false;
  }

  //Post Method
  static Future<Map<String, dynamic>> postDioHttpMethod({
    BuildContext? context,
    required String url,
    dynamic data,
    Options? header,
  }) async {
    var internet = await check();
    if (internet) {
      try {
        debugPrint("URL :" "$url");
        Response response = await _dio!.post(
          "$url",
          data: data,
          options: header ?? _cacheOptions,
        );
        // ignore: prefer_typing_uninitialized_variables
        var responseBody;
        if (response.statusCode == 200) {
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            debugPrint('decode error');
            responseBody = response.data;
          }
          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else if (response.statusCode == 201) {
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            debugPrint('decode error');
            responseBody = response.data;
          }
          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else {
          return {
            'body': responseBody,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } on DioError catch (error) {
        print(error.response?.data);
        print(error.response?.statusMessage);
        print(error.error);
        print(error.message);
        print(error.response);
        Map<String, dynamic> responseData = {
          'body': null,
          'headers': null,
          'error_description': await _handleError(
            error,
            context,
            message: error.response?.data['message'],
          ),
        };
        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Bad Internet Connection",
      };
      internetError.addOverlayEntry(context);
      return responseData;
    }
  }

  //Post Method
  static Future<Map<String, dynamic>> deleteDioHttpMethod(
      {BuildContext? context,
      required String url,
      data,
      Options? header}) async {
    var internet = await check();
    if (internet) {
      if (context != null) processIndicator.show(context);
      try {
        debugPrint(data);
        log("URL :" "$url");
        Response response = await _dio!.delete(
          "$url",
          data: data,
          options: header ?? _cacheOptions,
        );
        // ignore: prefer_typing_uninitialized_variables
        var responseBody;
        debugPrint(response.toString());
        debugPrint(response.statusCode.toString());
        if (response.statusCode == 200) {
          if (context != null) processIndicator.hide(context);
          try {
            responseBody = json.decode(json.encode(response.data));
          } catch (error) {
            debugPrint('decode error');
            responseBody = response.data;
          }
          return {
            'body': responseBody,
            'headers': response.headers,
            'error_description': null,
          };
        } else {
          if (context != null) processIndicator.hide(context);
          return {
            'body': null,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } on DioError catch (e) {
        Map<String, dynamic> responseData = {
          'body': null,
          'headers': null,
          'error_description': await _handleError(e, context,
              message: e.response?.data['message']),
        };
        if (context != null) processIndicator.hide(context);
        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry(context);
      return responseData;
      // func(false);
    }
  }

  // //Multiple Concurrent
  static Future<Map<String, dynamic>> multipleConcurrentDioHttpMethod(
      {BuildContext? context,
      required String getUrl,
      required String postUrl,
      required Map<String, dynamic> postData}) async {
    try {
      if (context != null) processIndicator.show(context);
      List<Response> response = await Future.wait([
        _dio!.post("$endPointUrl/$postUrl",
            data: postData, options: _cacheOptions),
        _dio!.get("$endPointUrl/$getUrl", options: _cacheOptions)
      ]);
      if (response[0].statusCode == 200 || response[0].statusCode == 200) {
        if (response[0].statusCode == 200 && response[1].statusCode != 200) {
          if (context != null) processIndicator.hide(context);
          return {
            'getBody': null,
            'postBody': json.decode(response[0].data),
            'headers': response[0].headers,
            'error_description': null,
          };
        } else if (response[1].statusCode == 200 &&
            response[0].statusCode != 200) {
          if (context != null) processIndicator.hide(context);
          return {
            'getBody': null,
            'postBody': json.decode(response[0].data),
            'headers': response[0].headers,
            'error_description': null,
          };
        } else {
          if (context != null) processIndicator.hide(context);
          return {
            'postBody': json.decode(response[0].data),
            'getBody': json.decode(response[0].data),
            'headers': response[0].headers,
            'error_description': null,
          };
        }
      } else {
        if (context != null) processIndicator.hide(context);
        return {
          'postBody': null,
          'getBody': null,
          'headers': null,
          'error_description': "Something Went Wrong",
        };
      }
    } catch (e) {
      Map<String, dynamic> responseData = {
        'postBody': null,
        'getBody': null,
        'headers': null,
        'error_description': await _handleError(e, context),
      };
      if (context != null) processIndicator.hide(context);
      return responseData;
    }
  }

  //Sending FormData
  static Future<Map<String, dynamic>> sendingFormDataDioHttpMethod({
    required BuildContext? context,
    required String url,
    required Map<String, dynamic> data,
  }) async {
    var internet = await check();
    if (internet) {
      try {
        if (context != null) processIndicator.show(context);
        FormData formData = new FormData.fromMap(data);
        Response response = await _dio!
            .post("$endPointUrl$url", data: formData, options: _cacheOptions);
        if (response.statusCode == 200) {
          if (context != null) processIndicator.hide(context);
          return {
            'body': json.decode(response.data),
            'headers': response.headers,
            'error_description': null,
          };
        } else {
          if (context != null) processIndicator.hide(context);
          return {
            'body': null,
            'headers': null,
            'error_description': "Something Went Wrong",
          };
        }
      } catch (e) {
        Map<String, dynamic> responseData = {
          'body': null,
          'headers': null,
          'error_description': await _handleError(e, context),
        };
        if (context != null) processIndicator.hide(context);
        return responseData;
      }
    } else {
      Map<String, dynamic> responseData = {
        'body': null,
        'headers': null,
        'error_description': "Internet Error",
      };
      internetError.addOverlayEntry(context);
      return responseData;
    }
  }

  // Handle Error
  static Future<String> _handleError(error, context, {message}) async {
    String errorDescription = "";
    try {
      debugPrint("In side try");
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint("In side internet condition");
        if (error is DioError) {
          // ignore: unnecessary_cast
          DioError dioError = error as DioError;
          switch (dioError.type) {
            case DioErrorType.connectTimeout:
              errorDescription = "Connection timeout with API server";
              debugPrint(errorDescription);
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout in connection with API server";
              debugPrint(errorDescription);
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              debugPrint(errorDescription);
              break;
            case DioErrorType.response:
              errorDescription = message;
              debugPrint(errorDescription);
              break;
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              debugPrint(errorDescription);
              break;
            case DioErrorType.other:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              debugPrint(errorDescription);
              break;
          }
        } else {
          errorDescription = "Unexpected error occurred";
          debugPrint(errorDescription);
        }
      }
    } on SocketException catch (_) {
      errorDescription = "Please check your internet connection";
      debugPrint(errorDescription);
    }

    if (errorDescription.contains("401")) {}
    return errorDescription;
  }
}

class NetworkCheck {
  Future<bool> check() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   return true;
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   return true;
    // }
    return false;
  }

  dynamic checkInternet(bool func) {
    check().then((internet) {
      if (internet) {
        return true;
      } else {
        return false;
      }
    });
  }
}
