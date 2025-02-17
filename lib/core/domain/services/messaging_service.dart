import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final Dio dio = Dio();
  final String? authToken;

  FirebaseMessagingService({required this.authToken});

  Future<String> getToken() async {
    return await messaging.getToken() ?? '';
  }

  Future<String> getAPNSToken() async {
    return await messaging.getAPNSToken() ?? '';
  }

  Future<NotificationSettings> setupPushNotifications() async {
    return await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  Future<Response?> sendDeviceToken({required Map<String, dynamic> data}) async {
    return _request(
      method: 'POST',
      endpoint: API.device_token,
      data: data,
    );
  }

  Future<Response?> fetchActivity() async {
    return _request(
      method: 'GET',
      endpoint: API.notification,
    );
  }

  Future<Response?> _request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    if (authToken == null || authToken!.isEmpty) {
      print("Auth token is missing.");
      return null;
    }

    try {
      Response response;
      String url = '${API.endpoint}$endpoint';

      Options options = Options(headers: {'Flic-Token': authToken!});

      if (method == 'POST') {
        response = await dio.post(url, data: data, options: options);
      } else {
        response = await dio.get(url, options: options);
      }

      print("Response: ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      print("Error: ${e.response?.statusCode} - ${e.response?.data}");
      return e.response;
    }
  }
}

