import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class CreateSubverseService {
  Dio dio = new Dio();

  createSubverse(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.categories}',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.statusCode);
      // print(response.data);
      return response.statusCode;
    } catch (e) {
      print(e);
      return (e);
    }
  }
}
