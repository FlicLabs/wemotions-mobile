import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class ChatService {
  Dio dio = new Dio();

  getMessages({required int page}) async {
    token = prefs!.getString('token');
    print('${API.endpoint}${API.messages}?page=$page&group_id=$group_id');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.messages}?page=$page&group_id=$group_id',
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );
      // print(response.statusCode);
      // print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return (e.response);
    }
  }

  fetchGroupMembers({required id}) async {
    print('${API.endpoint}${API.members}?group_id=$id');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.members}?group_id=$id',
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );
      // print(response.statusCode);
      // print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return (e.response);
    }
  }

  joinGroupChat({required Map data}) async {
    token = prefs!.getString('token');
    print('${API.endpoint}${API.join}');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.join}',
        data: data,
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );
      print(response.statusCode);
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response!.statusCode);
      print(e.response!.statusMessage);
      return (e.response);
    }
  }
}
