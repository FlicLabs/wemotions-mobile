import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';


class InviteService {
  Dio dio = new Dio();

  getActiveUsers() async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.active}?page=1',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }

    userFollow(String username) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.follow}/$username',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }

  userUnfollow(String username) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.unfollow}/$username',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }
}
