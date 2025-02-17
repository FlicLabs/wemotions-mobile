import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:socialverse/export.dart';

class PostService {
  final Dio _dio = Dio();

  Options getHeaders() {
    return Options(headers: {'Flic-Token': token ?? ''});
  }

  Future<Response?> getUploadToken() async {
    final String url = '${API.endpoint}${API.uploadToken}';
    debugPrint('Fetching upload token: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (getUploadToken): ${e.message}');
      return null;
    }
  }

  Future<http.StreamedResponse> createPost({
    required String hash,
    required String title,
    required String categoryId,
    required String isPrivate,
  }) async {
    final Uri uri = Uri.parse('${API.endpoint}${API.posts}');
    final request = http.MultipartRequest('POST', uri)
      ..fields.addAll({
        'title': title,
        'hash': hash,
        'is_available_in_public_feed': isPrivate,
        'category_id': categoryId,
      })
      ..headers.addAll({'Flic-Token': token ?? ''});

    debugPrint('Creating post: ${request.fields}');
    return request.send();
  }

  Future<http.StreamedResponse> createReply({
    required String hash,
    required String title,
    required String parentVideoId,
    required String categoryId,
    required String isPrivate,
  }) async {
    final Uri uri = Uri.parse('${API.endpoint}${API.posts}');
    final request = http.MultipartRequest('POST', uri)
      ..fields.addAll({
        'title': title,
        'hash': hash,
        'is_available_in_public_feed': isPrivate,
        'parent_video_id': parentVideoId,
        'category_id': categoryId,
      })
      ..headers.addAll({'Flic-Token': token ?? ''});

    debugPrint('Creating reply: ${request.fields}');
    return request.send();
  }

  Future<void> uploadVideo({
    required String uploadUrl,
    required String videoPath,
    required void Function(int percentage) onUploadProgress,
  }) async {
    final File file = File(videoPath);
    final int fileSize = file.lengthSync();
    final Stream<List<int>> stream = file.openRead();

    try {
      await _dio.put(
        uploadUrl,
        data: stream,
        onSendProgress: (int sent, int total) {
          int percentage = ((sent / total) * 100).round();
          onUploadProgress(percentage);
        },
        options: Options(
          contentType: "video/mp4",
          headers: {
            'Accept': "*/*",
            'Content-Length': fileSize.toString(),
            'Connection': 'keep-alive',
            'User-Agent': 'ClinicPlush'
          },
        ),
      );
      debugPrint('Video upload successful');
    } on DioException catch (e) {
      debugPrint('DioError (uploadVideo): ${e.message}');
    }
  }

  Future<Response?> searchUserForTagging(String query) async {
    final String url = '${API.endpoint}search?type=user&query=$query';
    debugPrint('Searching user: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (searchUserForTagging): ${e.message}');
      return null;
    }
  }

  Future<Response?> tagUser({required Map<String, dynamic> data}) async {
    final String url = '${API.endpoint}${API.posts}/tag';
    debugPrint('Tagging user: $url with data: $data');

    try {
      Response response = await _dio.post(url, data: data, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (tagUser): ${e.message}');
      return null;
    }
  }

  Future<Response?> removeTag({required Map<String, dynamic> data}) async {
    final String url = '${API.endpoint}${API.posts}/remove/tag';
    debugPrint('Removing tag: $url with data: $data');

    try {
      Response response = await _dio.delete(url, data: data, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (removeTag): ${e.message}');
      return null;
    }
  }

  Future<Response?> updateTags(int postId) async {
    final String url = '${API.endpoint}${API.posts}/$postId';
    debugPrint('Updating tags: $url');

    try {
      Response response = await _dio.get(url, options: getHeaders());
      return response;
    } on DioException catch (e) {
      debugPrint('DioError (updateTags): ${e.message}');
      return null;
    }
  }
}
