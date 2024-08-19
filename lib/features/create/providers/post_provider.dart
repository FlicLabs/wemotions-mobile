import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/domain/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final description = TextEditingController();
  final formKey = GlobalKey<FormState>();

  VideoPlayerController? videoController;
  final _service = PostService();

  final notification = getIt<NotificationProvider>();

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  bool _is_token_loading = false;
  bool get is_token_loading => _is_token_loading;

  bool _is_uploading_post = false;
  bool get is_uploading_post => _is_uploading_post;

  int _upload_percentage_value = 0;
  int get upload_percentage_value => _upload_percentage_value;

  bool _is_private = false;
  bool get is_private => _is_private;

  int _category_id = subverse_id;
  int get category_id => _category_id;

  set category_id(int value) {
    _category_id = value;
    notifyListeners();
  }

  String _subverse_name = 'Vible';
  String get subverse_name => _subverse_name;

  set subverse_name(String value) {
    _subverse_name = value;
    notifyListeners();
  }

  List<Category> _spheres = <Category>[];
  List<Category> get spheres => _spheres;

  Future<void> getUploadToken() async {
    _is_token_loading = true;
    final response = await _service.getUploadToken();
    if (response.data['status'] == 'success') {
      UserPreferences().saveUploadToken(
        url: response.data['url'],
        hash: response.data['hash'],
      );
      log('flutter: ${response.data['url']}');
      log('flutter: ${response.data['hash']}');
      _is_token_loading = false;
      notifyListeners();
    }
  }

  Future<void> uploadVideo({required path}) async {
    Dio dio = new Dio();
    _is_uploading_post = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? upload_url = prefs.getString('url');
    log(upload_url.toString());
    var video_path = File(path).readAsBytesSync();
    await dio.put(
      upload_url!,
      data: Stream.fromIterable(video_path.map((e) => [e])),
      onSendProgress: (int sent, int total) {
        _upload_percentage_value = (sent / total * 100).round();
        notifyListeners();
      },
      options: Options(
        contentType: "mp4",
        headers: {
          'Accept': "*/*",
          'Content-Length': video_path.length,
          'Connection': 'keep-alive',
          'User-Agent': 'ClinicPlush'
        },
      ),
    );
    await createPost();
  }

  Future<void> createPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hash = prefs.getString('hash');
    var response = await _service.createPost(
      hash: hash ?? '',
      title: description.text,
      is_private: '${_is_private}',
      category_id: '${_category_id}',
    );

    response.listen(
      (value) {
        dynamic response = jsonDecode(value);
        if (response['status'] == 'success') {
          // log(response.toString());
          // log(response['status']);
          HapticFeedback.mediumImpact();
          _is_uploading_post = false;
          _upload_percentage_value = 0;
          description.clear();
          notifyListeners();
          notification.show(
            title: 'Your post has been created!',
            type: NotificationType.local,
          );
        } else {
          HapticFeedback.mediumImpact();
          _is_uploading_post = false;
          notifyListeners();
        }
      },
    );
  }

  void initVideo({required XFile file}) {
    videoController = VideoPlayerController.file(File(file.path))
      ..initialize().then(
        (_) {
          notifyListeners();
        },
      );
  }
}
