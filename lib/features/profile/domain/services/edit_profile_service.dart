import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class EditProfileService {
  Dio dio = new Dio();

  updateProfile(Map data) async {
    try {
      Response response = await dio.put(
        '${API.endpoint}${API.updateProfile}',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      print(e);
      return e;
    }
  }

  uploadImage(dynamic data) async {
    token = prefs?.getString('token');
    try {
      print('${API.endpoint}${API.user}/picture/upload');
      Response response = await dio.post(
        '${API.endpoint}${API.user}/picture/upload',
        data: data,
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.statusCode);
      print(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      // print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }


  updateUsername(Map data) async {
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
      log('error');
      print(e.response?.statusCode);
      print(e.response?.data);
      return e;
    }
  }

  getUsername({required String username}) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.profile}/$username',
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
