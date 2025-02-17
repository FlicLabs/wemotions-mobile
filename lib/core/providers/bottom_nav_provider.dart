import 'package:socialverse/export.dart';

class BottomNavBarProvider extends ChangeNotifier {
  final PageController bottomPageController = PageController(initialPage: 0);

  int _currentPage = 0;
  int get currentPage => _currentPage;

  set currentPage(int val) {
    if (_currentPage != val) {
      _currentPage = val;
      notifyListeners();
    }
  }

  void jumpToPage() {
    bottomPageController.jumpToPage(_currentPage);
  }

  int? _parentVideoId;
  int? get parentVideoId => _parentVideoId;

  set parentVideoId(int? id) {
    if (_parentVideoId != id) {
      _parentVideoId = id;
      notifyListeners();
    }
  }

  String _selectedVideoUploadType = "Video";
  String get selectedVideoUploadType => _selectedVideoUploadType;

  set selectedVideoUploadType(String val) {
    if (_selectedVideoUploadType != val) {
      _selectedVideoUploadType = val;
      notifyListeners();
    }
  }
}
