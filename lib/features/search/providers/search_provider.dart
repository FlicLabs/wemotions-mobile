import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

enum Sort {
  reply_count,
  online,
}

class SearchProvider extends ChangeNotifier {
  final notification = getIt<NotificationProvider>();
  final search = TextEditingController();
  late TabController tabController;
  final _service = SubverseService();

  ScrollController _controller = ScrollController();
  ScrollController get controller => _controller;

  SearchProvider() {
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !_isFetching) {
        _fetchMoreContent();
      }
    });
  }

  void changeTabControllerIndex(final int index) {
    tabController.index = index;
    notifyListeners();
  }

  Sort _sort = Sort.reply_count;
  Sort get sort => _sort;

  set sort(Sort value) {
    if (_sort != value) {
      _sort = value;
      _posts_page = 1;
      _loading = true;
      posts.clear();
      exits.clear();
      notifyListeners();
      fetchCurrentSortedPosts;
    }
  }

  bool _loading = false;
  bool get loading => _loading;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  int _posts_page = 1;
  int get posts_page => _posts_page;

  set posts_page(int value) {
    _posts_page = value;
    notifyListeners();
  }

  bool _isGridView = false;
  bool get isGridView => _isGridView;

  set isGridView(bool value) {
    _isGridView = value;
    notifyListeners();
  }

  Category _subverse_info = Category.empty;
  Category get subverse_info => _subverse_info;

  set subverse_info(Category user) {
    _subverse_info = user;
    notifyListeners();
  }

  final Map<Sort, String> sortName = {
    Sort.reply_count: 'Reply Count',
    Sort.online: 'Online',
  };

  String get sortDisplayName {
    switch (_sort) {
      case Sort.reply_count:
        return 'Reply Count';
      case Sort.online:
        return 'Online';
      default:
        return '';
    }
  }

  Future<void> _fetchMoreContent() async {
    _isFetching = true;
    _posts_page++;
    // log('page: $_posts_page');
    try {
      switch (_sort) {
        case Sort.reply_count:
          await getSubversePosts();
          break;
        case Sort.online:
          await getPostsByExitCount(id: subverse_id);
          break;
        default:
          await getSubversePosts();
      }
    } catch (error) {
      // log('Error: $error');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  get fetchCurrentSortedPosts {
    switch (_sort) {
      case Sort.reply_count:
        getSubversePosts(isRefresh: true);
        break;
      case Sort.online:
        getPostsByExitCount(id: subverse_id, isRefresh: true);
        break;
      default:
        getSubversePosts(isRefresh: true);
    }
  }

  List<Posts> get currentSortedPosts {
    switch (_sort) {
      case Sort.reply_count:
        return _posts;
      case Sort.online:
        return _exits;
      default:
        return _posts;
    }
  }

  set currentSortedPosts(List<Posts> value) {
    switch (_sort) {
      case Sort.reply_count:
        _posts = value;
        break;
      case Sort.online:
        _exits = value;
        break;
      default:
        _posts = value;
    }
    notifyListeners();
  }

  List<Category> _spheres = <Category>[];
  List<Category> get spheres => _spheres;

  List<Posts> _posts = <Posts>[];
  List<Posts> get posts => _posts;

  List<Posts> _exits = <Posts>[];
  List<Posts> get exits => _exits;

  List<Posts> _views = <Posts>[];
  List<Posts> get views => _views;

  List<UserSearchModel> _user_search = <UserSearchModel>[];
  List<UserSearchModel> get user_search => _user_search;

  List<PostSearchModel> _post_search = <PostSearchModel>[];
  List<PostSearchModel> get post_search => _post_search;

  List<SubverseSearchModel> _subverse_search = <SubverseSearchModel>[];
  List<SubverseSearchModel> get subverse_search => _subverse_search;

  List<UserSearchModel> _search_history = [];
  List<UserSearchModel> get search_history => _search_history;

  // set search_history(UserSearchModel val){
  //   _search_history.add(val);
  // }


  void assignToSearch(UserSearchModel val){
    bool alreadyThere=false;

    _search_history.forEach((element) {
      if(element.username==val.username){
        alreadyThere = true;
      }
    });
    if(!alreadyThere) {
      _search_history.add(val);
      notifyListeners();
    }
  }

  void removeFromSearch(UserSearchModel val){
    _search_history= _search_history.where((element) => element.username!=val.username).toList();
    notifyListeners();
  }


  onChanged(context, {required String query}) async {
    if (tabController.index == 0 ||
        //tabController.index == 1 ||
        tabController.index == 1) {
      await searchUser(context, query: query);
      //await searchSubverse(context, query: query);
      await searchPost(context, query: query);
    }
    notifyListeners();
  }

  Future<void> searchUser(context, {required String query}) async {
    Response response = await _service.search(query: query, type: 'user');
    if (response.statusCode == 200 || response.statusCode == 201) {
      String jsonString = json.encode(response.data);
      log('the _usersearch data before: ${_user_search.length}');
      _user_search = (json.decode(jsonString) as List)
          .map((data) => UserSearchModel.fromJson(data))
          .toList();
      log('the _usersearch data after: ${_user_search.length}');

      notifyListeners();
    } else {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }

  Future<void> searchSubverse(context, {required String query}) async {
    Response response = await _service.search(query: query, type: 'category');
    if (response.statusCode == 200 || response.statusCode == 201) {
      String jsonString = json.encode(response.data);
      _subverse_search = (json.decode(jsonString) as List)
          .map((data) => SubverseSearchModel.fromJson(data))
          .toList();
      notifyListeners();
    } else {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }

  Future<void> searchPost(context, {required String query}) async {
    Response response = await _service.search(query: query, type: 'post');
    log('the searchpost response is: ${response.data.length}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      String jsonString = json.encode(response.data);
      _post_search = (json.decode(jsonString) as List)
          .map((data) => PostSearchModel.fromJson(data))
          .toList();
      notifyListeners();
    } else {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    }
  }

  Future<void> getSubverseInfo({required int id}) async {
    Response response = await _service.getSubverseInfo(id: id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      String jsonString = json.encode(response.data);
      final Map<String, dynamic> responseData = json.decode(jsonString);
      Category subverseInfo = Category.fromJson(responseData);
      _subverse_info = subverseInfo;
    }
    notifyListeners();
  }

  Future<void> getSubversePosts({bool? isRefresh}) async {
    isRefresh == true ? _posts.clear() : null;
    Response response = await _service.getSubversePosts(page: _posts_page);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final posts = SubverseModel.fromJson(response.data).posts;
      _posts.addAll(posts.toList());
      _loading = false;
      notifyListeners();
    } else {}
  }

  Future<void> getPostsByExitCount({required int id, bool? isRefresh}) async {
    isRefresh == true ? _exits.clear() : null;
    Response response = await _service.getPostsByExitCount(
      id: id,
      page: _posts_page,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final posts = SubverseModel.fromJson(response.data).posts;
      _exits.addAll(posts.toList());
      _loading = false;
      notifyListeners();
    } else {}
  }

  Future<void> getPostsByViewCount({required int id, bool? isRefresh}) async {
    isRefresh == true ? _exits.clear() : null;
    Response response = await _service.getPostsByViewCount(
      id: id,
      page: _posts_page,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final posts = SubverseModel.fromJson(response.data).posts;
      _views.addAll(posts.toList());
      _loading = false;
      notifyListeners();
    } else {}
  }
}
