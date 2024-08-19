import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class EditSubverseService {
  Dio dio = new Dio();

  updateDescription(Map data, int id) async {
    try {
      print('${API.endpoint}${API.categories}/$id');
      Response response = await dio.put(
        '${API.endpoint}${API.categories}/$id',
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

  uploadImage(dynamic data, int id) async {
    try {
      print('${API.endpoint}${API.categories}/$id/image');
      Response response = await dio.post(
        '${API.endpoint}${API.categories}/$id/image',
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
