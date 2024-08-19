import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:socialverse/export.dart';

class ProfileService {
  Dio dio = new Dio();

  getUserProfile({required String username, bool? forceRefresh}) async {
    print('${API.endpoint}${API.profile}/$username');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.profile}/$username',
        options: buildCacheOptions(
          Duration(days: 1),
          forceRefresh: forceRefresh,
          options: Options(headers: {'Flic-Token': token ?? ''}),
        ),
      );
      // print(response);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response);
    }
  }

  getPosts(String username, int page) async {
    print('${API.endpoint}users/$username/posts?page=$page');
    try {
      Response response = await dio.get(
        '${API.endpoint}users/$username/posts?page=$page',
        options: buildCacheOptions(
          Duration(days: 1),
          // forceRefresh: true,
          options: Options(headers: {'Flic-Token': token ?? ''}),
        ),
      );
      // print(response.data);
      // print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }

  getLikedPosts() async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.posts}/liked',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.statusCode);
      // print(response.data);
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

  blockUser(String username) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.block}/$username',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      // print(e.response?.statusMessage);
      // print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }

  unblockUser(String username) async {
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.unblock}/$username',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      return response.statusCode;
    } on DioError catch (e) {
      // print(e.response?.statusMessage);
      // print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }

  getActiveUsers(String username) async {
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

  getFollowing(String username) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.following}/$username',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }

  getFollowers(String username) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.followers}/$username',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      // print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      return (e.response?.statusCode);
    }
  }
}
