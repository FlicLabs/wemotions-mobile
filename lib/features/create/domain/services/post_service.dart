import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:socialverse/export.dart';

class PostService {
  Dio dio = new Dio();

  getUploadToken() async {
    token = prefs?.getString('token');
    Response response = await dio.get(
      '${API.endpoint}${API.uploadToken}',
      options: Options(
        headers: {'Flic-Token': token ?? ''},
      ),
    );
    return response;
  }

  Future<dynamic> createPost({
    required String hash,
    required String title,
    String? category_id,
    String? is_private,
  }) async {
    var uri = Uri.parse('${API.endpoint}${API.posts}');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'title': title,
      'hash': hash,
      'is_available_in_public_feed': is_private!,
      'category_id': category_id!,
    });
    request.headers.addAll({'Flic-Token': token ?? ''});
    var response = await request.send();
    print(response);
    print(response.reasonPhrase);
    print(response.statusCode);
    return response.stream.transform(utf8.decoder);
  }

  Future<dynamic> createReply({
    required String hash,
    required String title,
    String? category_id,
    String? is_private,
    required String parent_video_id
  }) async {
    print({
      'title': title,
      'hash': hash,
      'is_available_in_public_feed': is_private!,
      'parent_video_id' : parent_video_id,
      'category_id': category_id!,
    });
    var uri = Uri.parse('${API.endpoint}${API.posts}');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'title': title,
      'hash': hash,
      'is_available_in_public_feed': is_private!,
      'parent_video_id' : parent_video_id,
      // 'category_id': category_id!,
    });
    request.headers.addAll({'Flic-Token': token ?? ''});
    var response = await request.send();
    print(response);
    print(response.reasonPhrase);
    print(response.statusCode);
    return response.stream.transform(utf8.decoder);
  }

  uploadVideo({
    required upload_url,
    required video_path,
    required upload_percentage_value,
  }) async {
    var path = File(video_path).readAsBytesSync();
    await dio.put(
      upload_url,
      data: Stream.fromIterable(path.map((e) => [e])),
      onSendProgress: (int sent, int total) {
        upload_percentage_value = (sent / total * 100).round();
      },
      options: Options(
        contentType: "mp4",
        headers: {
          'Accept': "*/*",
          'Content-Length': path.length,
          'Connection': 'keep-alive',
          'User-Agent': 'ClinicPlush'
        },
      ),
    );
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
      print(e.response);
      print(e);
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
      print(e.response);
      print(e);
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
