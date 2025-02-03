import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class AuthService {
  Dio dio = new Dio();

  Future<Response> login(Map data) async {
    try {
      final response = await dio.post(
        '${API.endpoint}${API.login}',
        data: data,
      );
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw 'Invalid username or email';
      } else if (e.response?.statusCode == 404) {
        throw 'Oh no! Your credentials do not match!';
      }
      throw 'Something went wrong';
    }
  }

  Future<Response> signUp(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.signup}',
        data: data,
      );
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data['message']);
      if (e.response?.statusCode == 400) {
        throw e.response?.data['message'];
      }
      throw 'Something went wrong';
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
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e;
    }
  }

  reset(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.reset}/start',
        data: data,
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e;
    }
  }
}
