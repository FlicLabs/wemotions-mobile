import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:socialverse/export.dart';

class EditProfileProvider extends ChangeNotifier {
  final username = TextEditingController();
  final name = TextEditingController();
  final firstname = TextEditingController();
  final surname = TextEditingController();
  final bio = TextEditingController();
  final instagram = TextEditingController();
  final tiktok = TextEditingController();
  final youtube = TextEditingController();
  final website = TextEditingController();

  final _service = EditProfileService();

  CroppedFile? selectedImage;
  final notification = getIt<NotificationProvider>();

  ProfileModel _user = ProfileModel.empty;
  ProfileModel get user => _user;

  bool _loading = false;
  bool get loading => _loading;

  bool _edited = false;
  bool get edited => _edited;

  set edited(bool value) {
    _edited = value;
    notifyListeners();
  }

  bool _updated = false;
  bool get updated => _updated;

  set updated(bool updated) {
    _updated = updated;
    notifyListeners();
  }

  bool _uploadedImage = false;
  bool get uploadedImage => _uploadedImage;

  Future<void> selectProfilePhoto(context) async {
    final pickedFile = await ImageHelper.pickedImageFromGallery(
      context: context,
      cropStyle: CropStyle.rectangle,
    );
    if (pickedFile != null) {
      selectedImage = pickedFile;
      notifyListeners();
    }
  }

  Future<dynamic> uploadImage() async {
    _loading = true;
    notifyListeners();

    String fileName = selectedImage!.path.split('/').last;

    var data = dio.FormData.fromMap({
      "avatar": await dio.MultipartFile.fromFile(
        selectedImage!.path,
        filename: fileName,
      ),
    });

    final response = await _service.uploadImage(data);

    if (response == 200 || response == 201) {
      selectedImage = null;
      // _updated = true;
      // _loading = false;
      // _uploadedImage = true;
      // notifyListeners();

      // getIt<SettingsProvider>().getUserSubverses();
    } else {
      _loading = false;
      notifyListeners();
      notification.show(
        title: 'An error occurred, Please try again!',
        type: NotificationType.local,
      );
    }
    return response;
  }

  Future<int> updateProfile(context) async {
    _loading = true;
    notifyListeners();
    Map data = {
      "first_name": firstname.text.trim(),
      "last_name": surname.text.trim(),
      "bio": bio.text.trim(),
      "youtube_url": youtube.text.trim(),
      "tiktok_url": tiktok.text.trim(),
      "instagram_url": instagram.text.trim(),
      "website": website.text.trim(),
    };

    final response = await _service.updateProfile(data);
    if (response == 200 || response == 201) {
      _loading = false;
      notifyListeners();
      Navigator.pop(context);
      notification.show(
        title: 'Your profile has been updated',
        type: NotificationType.local,
      );
    } else {
      _loading = false;
      notifyListeners();
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }

    return response;
  }

  Future<int> updateUsername(context) async {
    log('init');
    _loading = true;
    notifyListeners();

    Map data = {
      "new_username": username.text.trim(),
    };

    log('updating username');
    Response response = await _service.updateUsername(data);

    if (response.data['status'] == 'success') {
      Response response = await _service.getUsername(
        username: username.text.trim(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String jsonString = json.encode(response.data);
        final Map<String, dynamic> responseData = json.decode(jsonString);
        var userData = responseData;
        ProfileModel userProfile = ProfileModel.fromJson(userData);
        _user = userProfile;
        prefs!.setString("username", user.username);
        prefs_username = prefs?.getString('username') ?? '';

        // log('load user profile');
        // getIt<UserProfileProvider>().getUserProfile(
        //   context,
        //   username: prefs_username!,
        //   fromUser: true,
        // );

        _loading = false;
        notifyListeners();

        navKey.currentState!
          ..pop()
          ..pop();
      }

      notification.show(
        title: 'Your username has been updated',
        type: NotificationType.local,
      );
    } else if (response.data['status'] == 'error') {
      username.text = '';
      _loading = false;
      notifyListeners();
      notification.show(
        title: 'Username already exists',
        type: NotificationType.local,
      );
    } else {
      _loading = false;
      notifyListeners();
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }

    return response.statusCode!;
  }

  Future<int> updateLinks(context) async {
    _loading = true;
    notifyListeners();
    Map data = {
      "bio": bio.text.trim(),
      "youtube_url": youtube.text.trim(),
      "tiktok_url": tiktok.text.trim(),
      "instagram_url": instagram.text.trim(),
      "website": website.text.trim(),
    };

    final response = await _service.updateProfile(data);
    if (response == 200 || response == 201) {
      _loading = false;
      notifyListeners();

      notification.show(
        title: 'Your links have been updated',
        type: NotificationType.local,
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      _loading = false;
      notifyListeners();

      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }

    return response;
  }
}
