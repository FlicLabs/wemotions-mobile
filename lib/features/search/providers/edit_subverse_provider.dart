import 'package:socialverse/export.dart';
import 'package:dio/dio.dart' as dio;

class EditSubverseProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final _service = EditSubverseService();

  final notification = getIt<NotificationProvider>();

  CroppedFile? selectedImage;

  bool _loading = false;
  bool get loading => _loading;

  bool _updated = false;
  bool get updated => _updated;

  set updated(bool updated) {
    _updated = updated;
    notifyListeners();
  }

  Future<void> selectSubversePhoto(context) async {
    final pickedFile = await ImageHelper.pickedImageFromGallery(
      context: context,
      cropStyle: CropStyle.rectangle,
    );
    if (pickedFile != null) {
      selectedImage = pickedFile;
      notifyListeners();
    }
  }

  Future<void> updateDescription(context, {required int id}) async {
    _loading = true;
    notifyListeners();
    Map data = {
      "description": description.text,
    };
    final response = await _service.updateDescription(data, id);
    if (response == 200 || response == 201) {
      _updated = true;
      _loading = false;
      notifyListeners();

      navKey.currentState!
        ..pop()
        ..pop();

      notification.show(
        title: 'Subverse has been updated',
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
  }

  Future<void> uploadImage(context, {required int id}) async {
    _loading = true;
    notifyListeners();
    String fileName = selectedImage!.path.split('/').last;

    var data = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(
        selectedImage!.path,
        filename: fileName,
      ),
    });

    final response = await _service.uploadImage(data, id);
    if (response == 200 || response == 201) {
      _updated = true;
      _loading = false;
      notifyListeners();
      // floatingScaffold(context, message: 'Subverse has been updated');
      // Navigator.pop(context);
    } else {
      // floatingScaffold(
      //   context,
      //   message: 'An error occurred, Please try again!',
      // );
    }
  }
}
