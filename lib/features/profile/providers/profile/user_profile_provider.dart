import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:socialverse/export.dart';

class UserProfileProvider extends ChangeNotifier {
  final notification = getIt<NotificationProvider>();

  ProfileModel _user = ProfileModel.empty;
  ProfileModel get user => _user;
  final _service = ProfileService();

  set user(ProfileModel user) {
    _user = user;
    notifyListeners();
  }

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  int _tab = 0;
  int get tab => _tab;

  set tab(int value) {
    _tab = value;
    notifyListeners();
  }

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  set isFollowing(bool value) {
    _isFollowing = value;
    notifyListeners();
  }

  bool _isBlocked = false;
  bool get isBlocked => _isBlocked;

  set isBlocked(bool value) {
    _isBlocked = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  toggleFollowing(int index) {
    HapticFeedback.mediumImpact();
    following[index].isFollowing = !following[index].isFollowing;
    notifyListeners();
  }

  toggleFollowers(int index) {
    HapticFeedback.mediumImpact();
    followers[index].isFollowing = !followers[index].isFollowing;
    notifyListeners();
  }

  List<Posts> _posts = <Posts>[];
  List<Posts> get posts => _posts;

  set posts(List<Posts> value) {
    _posts = value;
    notifyListeners();
  }

  List<Posts> _likedPosts = <Posts>[];
  List<Posts> get likedPosts => _likedPosts;

  List<Users> _following = <Users>[];
  List<Users> get following => _following;

  List<Users> _followers = <Users>[];
  List<Users> get followers => _followers;

  void onTabChanged(index) {
    _tab = index;
    notifyListeners();
  }

  // TODO: refactor response parsing with new method

  Future<void> getUserProfile({
    required String username,
    bool? forceRefresh,
  }) async {
    try {
      _loading = true;
      Response response = await _service.getUserProfile(
        username: username,
        forceRefresh: forceRefresh,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _user = ProfileModel.fromJson(response.data);
        _loading = false;
        notifyListeners();
      } else {
        notification.show(
          title: 'Something went wrong',
          type: NotificationType.local,
        );
        _loading = false;
      }
    } catch (e) {
      _loading = false;
      notification.show(
        title: 'Failed to load profile data',
        type: NotificationType.local,
      );
    }
  }

  Future<void> getUserPosts({required String username}) async {
    try {
      if (_loading) return;
      _loading = true;

      Response response = await _service.getPosts(username, page);
      final newPosts = ProfilePostsModel.fromJson(response.data).posts;

      if (newPosts.isNotEmpty) {
        _posts.addAll(newPosts);
        _page++;
      }

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      notification.show(
        title: 'Failed to load posts',
        type: NotificationType.local,
      );
    }
  }

  Future<void> getUserLikedPosts() async {
    List<Posts> _likedTemp = <Posts>[];
    final response = await _service.getLikedPosts();
    String jsonString = json.encode(response);
    _likedTemp = (json.decode(jsonString) as List)
        .map((data) => Posts.fromJson(data))
        .toList();
    _likedPosts = _likedTemp.reversed.toList();
    notifyListeners();
  }

  Future<void> userFollow({
    required String username,
  }) async {

    try{
      final response = await _service.userFollow(username);
      if (response == 200 || response == 201) {
        getUserProfile(
          username: username,
        );
      }
    }catch(e){
      final errorMessage = e.toString().replaceAll('Exception: ', '');

      notification.show(
        title: errorMessage,
        type: NotificationType.local,
      );

      log(errorMessage.toString()+' while follow');
    }
  }

  Future<void> userUnfollow({
    required String username,
  }) async {

    try{
      final response = await _service.userUnfollow(username);
      if (response == 200 || response == 201) {
        await getUserProfile(
          username: username,
        );
      }
    }catch(e){
      final errorMessage = e.toString().replaceAll('Exception: ', '');

      notification.show(
        title: errorMessage,
        type: NotificationType.local,
      );

      log(errorMessage.toString()+' while unfollow');
    }
  }

  void followUser({
    required String username,
    required bool isFollowing,
    bool? fromUser,
  }) {
    if (isFollowing == true) {
      userUnfollow(username: username);
    } else {
      userFollow(username: username);
    }
  }

  Future<void> getFollowing({
    required String username,
  }) async {

    try{

      List<Users> _temp = <Users>[];
      final Response response = await _service.getFollowing(username);
      String jsonString = json.encode(response.data);
      _temp = (json.decode(jsonString) as List)
          .map((data) => Users.fromJson(data))
          .toList();
      _following = _temp;
      notifyListeners();

    }catch(e){
      final errorMessage = e.toString().replaceAll('Exception: ', '');

      notification.show(
      title: errorMessage,
      type: NotificationType.local,
      );

      log(errorMessage.toString()+' while getFollowing');
    }
  }

  Future<void> getFollowers({
    required String username,
  }) async {

    try{

      List<Users> _temp = <Users>[];
      final Response response = await _service.getFollowers(username);
      String jsonString = json.encode(response.data);
      _temp = (json.decode(jsonString) as List)
          .map((data) => Users.fromJson(data))
          .toList();
      _followers = _temp;
      notifyListeners();

    }catch(e){

      final errorMessage = e.toString().replaceAll('Exception: ', '');

      notification.show(
        title: errorMessage,
        type: NotificationType.local,
      );

      log(errorMessage.toString()+' while getFollowers');

    }
  }



  Future<void> blockUser({
    required String username,
  }) async {
    final response = await _service.blockUser(username);
    if (response == 200 || response == 201) {
      getUserProfile(
        username: username,
      );
    }
  }

  Future<void> unblockUser({
    required String username,
  }) async {
    final response = await _service.unblockUser(username);
    if (response == 200 || response == 201) {
      getUserProfile(
        username: username,
      );
    }
  }
}
