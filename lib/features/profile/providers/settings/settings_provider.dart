import 'package:socialverse/export.dart';

class SettingsProvider extends ChangeNotifier {
  final _service = SettingsService();
  final notification = getIt<NotificationProvider>();

  Future<void> deleteAccount(context) async {
    final response = await _service.deleteAccount();
    if (response == 200 || response == 201) {
      UserPreferences().removeUser();
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }
}
