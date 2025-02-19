import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class SubscriptionService {
  Dio dio = new Dio();

  startSubscription(int id) async {
    Response response = await dio.post(
      '${API.endpoint}${API.categories}/$id/${API.subscription}',
      options: Options(headers: {'Flic-Token': token ?? ''}),
    );
    print(response);
    return response;
  }

  createSubscription(int id) async {
    Response response = await dio.post(
      '${API.endpoint}${API.categories}/$id/${API.product}',
      options: Options(headers: {'Flic-Token': token ?? ''}),
    );
    print(response);
    return response;
  }
}
