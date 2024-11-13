import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:socialverse/core/utils/constants/constants.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/domain/models/activer_users_model.dart';
import 'package:socialverse/features/profile/domain/models/users_model.dart';
import 'package:socialverse/features/profile/domain/services/invite_service.dart';


class InviteProvider extends ChangeNotifier {
  final _service = InviteService();

  List<Users> _active_users = <Users>[];
  List<Users> get active_users => _active_users;

  bool _loading = false;
  bool get loading => _loading;

  late bool _isFollowing;
  bool get isFollowing => _isFollowing;

  set isFollowing(bool value) {
    _isFollowing = value;
    notifyListeners();
  }

  late String _link;
  String get link => _link;

  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  Future<void> getContacts() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status.isGranted == true) {
      var contacts = await ContactsService.getContacts();
      _contacts = contacts.toList();
      notifyListeners();
    } else {
      // askPermission();
    }
  }

  Future<void> inviteContact(telephone) async {
    // String message = 'Join Empowerverse'; // Predefined invitation message
    // String uri = 'sms:${telephone}?body=$message';
    Uri sms = Uri(
      scheme: 'sms',
      path: telephone,
      queryParameters: {
        '': '',
        'body': invite_text + _link,
      },
    );
    launchUrl(
      Uri.parse(
        sms.toString().replaceAll('+', '%20'),
      ),
    );
  }

  Future<void> fetchActiveUsers() async {
    Response response = await _service.getActiveUsers();
    if (response.statusCode == 200 || response.statusCode == 201) {
      final users = ActiveUsersModel.fromJson(response.data).users;
      _active_users = users;
      notifyListeners();
    } else {}
    notifyListeners();
  }

  toggleFollowing(int index) {
    HapticFeedback.mediumImpact();
    active_users[index].isFollowing = !active_users[index].isFollowing;
    notifyListeners();
  }

  Future<void> userFollow({
    required String username,
  }) async {
    await _service.userFollow(username);
  }

  Future<void> userUnfollow({
    required String username,
  }) async {
    await _service.userUnfollow(username);
  }
}
