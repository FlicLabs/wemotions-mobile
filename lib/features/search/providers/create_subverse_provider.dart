import 'package:socialverse/export.dart';

class CreateSubverseProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  final notification = getIt<NotificationProvider>();

  final _service = CreateSubverseService();

  bool _loading = false;
  bool get loading => _loading;

  Future<void> createSubverse(context) async {
    _loading = true;
    notifyListeners();
    Map data = {
      "category_name": title.text,
      "category_description": description.text,
    };
    final response = await _service.createSubverse(data);
    if (response == 200 || response == 201) {
      title.clear();
      description.clear();
      _loading = false;
      notifyListeners();

      navKey.currentState!.pop();

      notification.show(
        title: 'Subverse has been created',
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
}
