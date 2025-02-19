import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class AccountService {
  Dio dio = new Dio();

  Future<Response> updateUsername(Map data) async {
    print('${API.endpoint}${API.updateUsername}');
    token = prefs?.getString('token');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.updateUsername}',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);

      throw 'Something Went Wrong';
    }
  }

  Future<Response> getUsername({required String username}) async {
    print('${API.endpoint}${API.profile}/$username');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.profile}/$username',
      );
      // print(response);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);

      if(e.response?.statusCode==404){
        throw 'User not found';
      }
      throw 'Something Went Wrong';
    }
  }


  Future <Response> logout() async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.logout}',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.statusCode);
      // print(response.statusMessage);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      throw 'Something Went Wrong';
    }
  }

  Future <Response> logoutEveryWhere() async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.logoutEverywhere}',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.statusCode);
      // print(response.statusMessage);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);

      throw 'Something Went Wrong';

    }
  }

  Future<Response> updateProfile(Map data) async {
    try {
      Response response = await dio.put(
        '${API.endpoint}${API.updateProfile}',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      print(response.statusCode);
      return response;
    }  on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      throw 'Something Went Wrong';
    }
  }

  Future<Response> resetPassword(Map data) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.reset}/finish',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      print(response.statusCode);
      return response;
    } catch (e) {
      print(e);
      throw 'Something went wrong';
    }
  }

}
