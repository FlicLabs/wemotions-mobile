import 'package:socialverse/export.dart';

class ReportProvider extends ChangeNotifier {

  final reason = TextEditingController();

  String? _reasonError = null;
  String? get reasonError => _reasonError;

  set reasonError(String? error) {
    _reasonError = error;
    notifyListeners();
  }

  String _selectedReason = "";

  String get selectedReason => _selectedReason;

  void selectReason(String? reason) {
    _selectedReason = reason ?? "";
    notifyListeners(); // Notify listeners about the change
  }

}
