import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class EditSubverseService {
  final Dio _dio = Dio();

  Future<int?> updateDescription(Map<String, dynamic> data, int id) async {
    try {
      final String url = '${API.endpoint}${API.categories}/$id';
      debugPrint('Updating description: $url');

      Response response = await _dio.put(
        url,
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      return response.statusCode;
    } on DioException catch (e) {
      debugPrint('DioError (updateDescription): ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected Error (updateDescription): $e');
      return null;
    }
  }

  Future<int?> uploadImage(dynamic data, int id) async {
    try {
      final String url = '${API.endpoint}${API.categories}/$id/image';
      debugPrint('Uploading image: $url');

      Response response = await _dio.post(
        url,
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      return response.statusCode;
    } on DioException catch (e) {
      debugPrint('DioError (uploadImage): ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected Error (uploadImage): $e');
      return null;
    }
  }
}
