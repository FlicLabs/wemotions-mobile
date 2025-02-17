import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class SubscriptionService {
  final Dio _dio = Dio();

  Future<Response?> startSubscription(int id) async {
    final String url = '${API.endpoint}${API.categories}/$id/${API.subscription}';
    debugPrint('Starting subscription: $url');

    try {
      Response response = await _dio.post(
        url,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (startSubscription): ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected Error (startSubscription): $e');
      return null;
    }
  }

  Future<Response?> createSubscription(int id) async {
    final String url = '${API.endpoint}${API.categories}/$id/${API.product}';
    debugPrint('Creating subscription: $url');

    try {
      Response response = await _dio.post(
        url,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (createSubscription): ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected Error (createSubscription): $e');
      return null;
    }
  }
}
