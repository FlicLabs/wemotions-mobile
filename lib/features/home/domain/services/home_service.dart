import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class HomeService {
  Dio dio = new Dio(BaseOptions(followRedirects: false));

  getFeed(int page, String token) async {
    print('${API.endpoint}${API.feed}?page=$page');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.feed}?page=$page',
        options: Options(headers: {'Flic-Token': token}),
      );
      ;
      // print(response.statusCode);
      // print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  getSinglePost({required int id}) async {
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.posts}/$id',
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

  postLikeAdd(int id) async {
    Response response = await dio.post(
      '${API.endpoint}${API.posts}/$id/upvote',
      options: Options(headers: {'Flic-Token': token ?? ''}),
    );
    print(response.data);
    return response.data;
  }

  view({required data}) async {
    token = prefs?.getString('token');
    // print('${API.endpoint}${API.view}');
    Response response = await dio.post(
      '${API.endpoint}${API.view}',
      data: data,
      options: Options(headers: {'Flic-Token': token}),
    );
    print(response.data['data']);
    return response;
  }

  inspire({required data}) async {
    token = prefs?.getString('token');
    print('${API.endpoint}${API.inspire}');
    Response response = await dio.post(
      '${API.endpoint}${API.inspire}',
      data: data,
      options: Options(headers: {'Flic-Token': token}),
    );
    print(response.data['data']);
    return response;
  }

  rating({required data}) async {
    token = prefs?.getString('token');
    print('${API.endpoint}${API.rating}');
    Response response = await dio.post(
      '${API.endpoint}${API.rating}',
      data: data,
      options: Options(headers: {'Flic-Token': token}),
    );
    print(response.data);
    return response;
  }

  postLikeRemove(int id) async {
    Response response = await dio.delete(
      '${API.endpoint}${API.posts}/$id/upvote',
      options: Options(headers: {'Flic-Token': token ?? ''}),
    );
    print(response.data);
    return response.data;
  }

  blockPost(int id) async {
    print('${API.endpoint}${API.posts}/$id/block');
    Response response = await dio.post(
      '${API.endpoint}${API.posts}/$id/block',
      options: Options(headers: {'Flic-Token': token}),
    );
    print(response.data);
    return response.data;
  }

  unblockPost(int id) async {
    Response response = await dio.post(
      '${API.endpoint}${API.posts}/$id/unblock',
      options: Options(headers: {'Flic-Token': token}),
    );
    print(response.data);
    return response.data;
  }

  deletePost(int id) async {
    print('${API.endpoint}${API.posts}/$id');
    try {
      Response response = await dio.delete(
        '${API.endpoint}${API.posts}/$id',
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

  deletePostAdmin(int id) async {
    try {
      Response response = await dio.delete(
        '${API.endpoint}${API.posts}/$id?api_key=',
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

  getReplies(int id, String token) async {
    print('${API.endpoint}${API.posts}/$id/replies');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.posts}/$id/replies',
        options: Options(headers: {'Flic-Token': token}),
      );
      ;
      // print(response.statusCode);
      // print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  getVotings() async {
    print('${API.endpoint}get/votings');
    try {
      Response response = await dio.get(
        '${API.endpoint}get/votings',
        options: Options(headers: {'Flic-Token': token}),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  addVoting({required data}) async {
    print('${API.endpoint}${API.posts}/add/votings');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.posts}/add/votings',
        data: data,
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  removeVoting({required data}) async {
    print('${API.endpoint}${API.posts}/remove/votings');
    try {
      Response response = await dio.delete(
        '${API.endpoint}${API.posts}/remove/votings',
        data: data,
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );

      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  updateVoting(int postId) async {
    print('${API.endpoint}${API.posts}/$postId');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.posts}/$postId',
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  searchUserForTagging(String query) async {
    print('${API.endpoint}search?type=user&query=$query');
    try {
      Response response = await dio.get(
        '${API.endpoint}search?type=user&query=$query',
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  tagUser({required data}) async{
    print('${API.endpoint}${API.posts}/tag');
    try {
      Response response = await dio.post(
        '${API.endpoint}${API.posts}/tag',
        data: data,
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  removeTag({required data}) async {
    print('${API.endpoint}${API.posts}/remove/tag');
    try {
      Response response = await dio.delete(
        '${API.endpoint}${API.posts}/remove/tag',
        data: data,
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }

  updateTags(int postId) async {
    print('${API.endpoint}${API.posts}/$postId');
    try {
      Response response = await dio.get(
        '${API.endpoint}${API.posts}/$postId',
        options: Options(
          headers: {'Flic-Token': token},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
      return e.response?.statusCode;
    }
  }
}
