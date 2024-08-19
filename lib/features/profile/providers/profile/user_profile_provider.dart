import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/domain/models/profile_posts_model.dart';
import 'package:socialverse/features/profile/domain/models/users_model.dart';

class UserProfileProvider extends ChangeNotifier {
  final dynamicLink = DynamicLinkRepository();
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
    Response response = await _service.getUserProfile(
      username: username,
      forceRefresh: forceRefresh,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      _posts.isEmpty ? getUserPosts(username: username) : null;
      String jsonString = json.encode(response.data);
      final Map<String, dynamic> responseData = json.decode(jsonString);
      // log('${responseData}');
      ProfileModel userProfile = ProfileModel.fromJson(responseData);
      _user = userProfile;
      notifyListeners();
    } else {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }

  Future<void> getUserPosts({required String username}) async {
    Response response = await _service.getPosts(username, page);
    final posts = ProfilePostsModel.fromJson(response.data).posts;
    _posts.addAll(posts.toList());
    _loading = false;
    notifyListeners();
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
    final response = await _service.userFollow(username);
    if (response == 200 || response == 201) {
      getUserProfile(
        username: username,
      );
    }
  }

  Future<void> userUnfollow({
    required String username,
  }) async {
    final response = await _service.userUnfollow(username);
    if (response == 200 || response == 201) {
      getUserProfile(
        username: username,
      );
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
    List<Users> _temp = <Users>[];
    final response = await _service.getFollowing(username);
    String jsonString = json.encode(response);
    _temp = (json.decode(jsonString) as List)
        .map((data) => Users.fromJson(data))
        .toList();
    _following = _temp;
    notifyListeners();
  }

  Future<void> getFollowers({
    required String username,
  }) async {
    List<Users> _temp = <Users>[];
    final response = await _service.getFollowers(username);
    String jsonString = json.encode(response);
    _temp = (json.decode(jsonString) as List)
        .map((data) => Users.fromJson(data))
        .toList();
    _followers = _temp;
    notifyListeners();
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
