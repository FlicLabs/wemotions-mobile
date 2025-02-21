import 'dart:developer';

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


  Future<Response> fetchActivity({int? page=null, int? page_size = null}) async {
    String url;
    if(page==null || page_size==null){
      url='${API.endpoint}${API.notification}';
    }else{
      url='${API.endpoint}${API.notification}?page=$page&page_size=$page_size';
    }

    print(url);

    try {
      Response response = await dio.get(
        url,
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

      log('${e.response?.data}  ${e.response?.statusCode} in fetchActivity');

      if (e.response?.statusCode == 401) {
        throw e.response?.data['message'];
      }


      throw 'Something went wrong';
    }
  }


  Future<Response> readNotification(int notificationId)async{
    print('${API.endpoint}${API.notification}');

    var data={
      "notification_id": notificationId
    };

    try{
      Response response = await dio.put(
        '${API.endpoint}${API.notification}',
        data: data,
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );

      //print(response.statusCode);
      // print(response.data);

      return response;

    }on DioError catch(e){
      print(e.response?.statusCode);
      print(e.response?.data);
      if(e.response?.statusCode==403){
        if(e.response?.data['message']=='Unauthorized access'){
          throw "You Can't Read this Notification";
        }
      }else if (e.response?.statusCode == 401) {
        throw e.response?.data['message'];
      }

      throw 'Something went wrong';
    }
  }


  Future<Response> deleteNotification(int notificationId)async{
    print('${API.endpoint}${API.notification}');

    var data={
      "notification_id": notificationId
    };

    try{
      Response response = await dio.delete(
        '${API.endpoint}${API.notification}',
        data: data,
        options: Options(
          headers: {'Flic-Token': token ?? ''},
        ),
      );

      //print(response.statusCode);
      // print(response.data);

      return response;

    }on DioError catch(e){
      print(e.response?.statusCode);
      print(e.response?.data);
      if(e.response?.statusCode==404){
        if(e.response?.data['message']=='Unauthorized access'){
          throw "You Can't Delete this Message";
        }

      }else if (e.response?.statusCode == 401) {
        throw e.response?.data['message'];
      }

      throw 'Something went wrong';
    }
  }

}
