import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class AuthService {
  Dio dio = new Dio();

  login(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.login}',
        data: data,
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e);
      return e;
    }
  }

  signUp(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.signup}',
        data: data,
      );
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e);
      return e;
    }
  }

  oauth(Map data) async {
    print('${API.endpoint}${API.oauth}');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.oauth}',
        data: data,
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e);
      return e;
    }
  }

  reset(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.reset}',
        data: data,
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e);
      return e;
    }
  }
}
