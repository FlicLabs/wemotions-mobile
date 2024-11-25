import 'package:socialverse/export.dart';

class BottomNavBarProvider extends ChangeNotifier {
  PageController bottomPageController = PageController(initialPage: 0);

  int _currentPage = 0;
  int get currentPage => _currentPage;

  set currentPage(val) {
    _currentPage = val;
    notifyListeners();
  }

  void jumpToPage() {
    bottomPageController.jumpToPage(currentPage);
    notifyListeners();
  }

  int? _parentVideoId;
  int? get parentVideoId => _parentVideoId;
  
  set parentVideoId(id) {
    _parentVideoId = id;
    notifyListeners();
  }

  String _selectedVideoUploadType = "Video";

  String get selectedVideoUploadType => _selectedVideoUploadType;

  set selectedVideoUploadType(val) {
    _selectedVideoUploadType = val;
    notifyListeners();
  }
}
