import 'package:socialverse/export.dart';

class ReportProvider extends ChangeNotifier {
  final reason = TextEditingController();

  String? _reasonError;
  String? get reasonError => _reasonError;

  set reasonError(String? error) {
    if (_reasonError != error) {
      _reasonError = error;
      notifyListeners();
    }
  }

  String _selectedReason = "";
  String get selectedReason => _selectedReason;

  void selectReason(String? reason) {
    if (_selectedReason != reason) {
      _selectedReason = reason ?? "";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    reason.dispose();
    super.dispose();
  }
}
