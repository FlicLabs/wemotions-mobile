import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class CreateSubverseService {
  final Dio _dio = Dio();

  Future<int?> createSubverse(Map<String, dynamic> data) async {
    try {
      Response response = await _dio.post(
        '${API.endpoint}${API.categories}',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      return response.statusCode;
    } on DioException catch (e) {
      debugPrint('DioError: ${e.message}'); // Better debugging
      return null;
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      return null;
    }
  }
}
