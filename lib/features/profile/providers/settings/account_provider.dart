import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class AccountProvider extends ChangeNotifier {
  final username = TextEditingController();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  // final password = TextEditingController();
  // final password_confirm = TextEditingController();



  String? _passwordError = null;
  String? get passwordError => _passwordError;

  set passwordError(String? error) {
    _passwordError = error;
    notifyListeners();
  }

  // clearPasswordController(){
  //   password.text='';
  //   // password_confirm.text='';
  //   notifyListeners();
  // }

  final notification = getIt<NotificationProvider>();

  final _service = AccountService();

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

  Future<bool> updateUsername(context) async {
    log('init');
    _loading = true;
    notifyListeners();

    Map data = {
      "new_username": username.text.trim(),
    };

    log('updating username');
    try{
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

          _loading = false;
          notifyListeners();

          navKey.currentState!
            ..pop()
            ..pop();
        }

        notification.show(
          title: 'Your username has been changed',
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
      }
    }catch(e){

      _loading = false;
      notifyListeners();
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );

      return false;
    }

    return true;
  }

  Future<void> logout({required BuildContext context,bool everyWhere=false}) async {
    _loading = true;
    notifyListeners();
    try{
      final Response response = everyWhere?(await _service.logoutEveryWhere()):(await _service.logout());
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserPreferences().removeUser();
        UserPreferences().removeWallet();
        prefs!.setBool("logged_in", false);
        prefs!.setBool("wallet_created", false);
        logged_in = prefs!.getBool('logged_in') ?? false;
        _loading = false;
        notifyListeners();
        Navigator.of(context, rootNavigator: true)
          ..pop()
          ..pop();
      } else if (response.statusCode != 200) {
        // await FirebaseAuth.instance.signOut();
        UserPreferences().removeUser();
        UserPreferences().removeWallet();
        prefs!.setBool("logged_in", false);
        prefs!.setBool("wallet_created", false);
        prefs!.setString("username", '');
        logged_in = prefs!.getBool('logged_in') ?? false;
        prefs_username = prefs?.getString('username') ?? '';
        _loading = false;
        notifyListeners();
        Navigator.of(context, rootNavigator: true)
          ..pop()
          ..pop()
          ..pop();
      } else {}
    }catch(e){
      _loading=false;
      notifyListeners();
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }

  Future<void> updateProfile(context) async {
    log('init');
    _loading = true;
    notifyListeners();
    
    Map data = {
      "first_name": firstName.text.trim(),
      "last_name": lastName.text.trim(),
      "new_username": username.text.trim(),
    };

    try{
      final Response response = await _service.updateProfile(data);
      if (response.statusCode == 200 || response == 201) {
        _loading = false;
        notifyListeners();
        Navigator.pop(context);
        notification.show(
          title: 'Your profile has been updated',
          type: NotificationType.local,
        );
      } else {}

    }catch(e){
      _loading = false;
      notifyListeners();
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }

    // return response;
  }

  // Future<void> resetPassword(BuildContext context)async {
  //
  //   _loading = true;
  //   notifyListeners();
  //
  //   log('reset password');
  //
  //   Map data= {
  //     "token": token ?? '',
  //   "password": password.text,
  //   "password-confirm": password_confirm.text
  //   };
  //
  //   // print("==============================================$data");
  //   try{
  //     final Response response = await _service.resetPassword(data);
  //     if (response.statusCode == 200) {
  //       _loading = false;
  //       notifyListeners();
  //       Navigator.pop(context);
  //       notification.show(
  //         title: 'Your password has been updated',
  //         type: NotificationType.local,
  //       );
  //     } else {}
  //
  //   }catch(e){
  //     _loading = false;
  //     notifyListeners();
  //     Navigator.pop(context);
  //     notification.show(
  //       title: 'Something went wrong',
  //       type: NotificationType.local,
  //     );
  //   }
  //
  // }

}
