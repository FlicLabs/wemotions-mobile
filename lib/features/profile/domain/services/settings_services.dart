import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class SettingsService {
  Dio dio = new Dio();

  deleteAccount() async {
    try {
      Response response = await dio.delete(
        '${API.endpoint}${API.user}',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.statusCode);
      print(response.statusMessage);
      return response.statusCode;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
