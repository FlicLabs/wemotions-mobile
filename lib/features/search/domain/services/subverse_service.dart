import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:socialverse/export.dart';

class SubverseService {
  Dio dio = new Dio();

  getSpheres({required int page, bool? forceRefresh}) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.categories}?page=$page',
        options: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: forceRefresh,
          options: Options(headers: {'Flic-Token': token ?? ''}),
        ),
      );
      // print(response.data);
      return response;
    } catch (e) {
      print(e);
      return e;
    }
  }

  getSubversePosts({required int id, required int page}) async {
    print('${API.endpoint}${API.categories}/$id/posts?page=$page');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.categories}/$id/posts?page=$page',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return e.response;
    }
  }

  getPostsByExitCount({required int id, required int page}) async {
    print('${API.endpoint}${API.subverse}/$id/posts/exitCount?page=$page');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.subverse}/$id/posts/exitCount?page=$page',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return e.response;
    }
  }

   getPostsByViewCount({required int id, required int page}) async {
    print('${API.endpoint}${API.subverse}/$id/posts/viewCount?page=$page');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.subverse}/$id/posts/viewCount?page=$page',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.data);
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return e.response;
    }
  }

  getSubverseInfo({required int id}) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.categories}/$id',
        options: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: true,
          options: Options(headers: {'Flic-Token': token ?? ''}),
        ),
      );
      // print(response.data);
      return response;
    } catch (e) {
      print(e);
      return e;
    }
  }

  search({required String query, required String type}) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.search}?query=$query&type=$type',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.data);
      return response;
    } catch (e) {
      print(e);
      return e;
    }
  }
}
