import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class FirebaseMessagingService {
  final messaging = FirebaseMessaging.instance;
  Dio dio = new Dio();

  Future<dynamic> getToken() async {
    String? token = await messaging.getToken() ?? '';
    return token;
  }

  Future<dynamic> getAPNSToken() async {
    String? token = await messaging.getAPNSToken() ?? '';
    return token;
  }

  Future<NotificationSettings> setupPushNotifications() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    return settings;
  }

  sendDeviceToken({required data}) async {
    token = prefs!.getString('token');
    print('${API.endpoint}${API.device_token}');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.device_token}',
        data: data,
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );
      print(response.statusCode);
      print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return (e.response);
    }
  }

  fetchActivity() async {
    print('${API.endpoint}${API.notification}');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.notification}',
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );
      //print(response.statusCode);
      // print(response.data);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return (e.response);
    }
  }
}
