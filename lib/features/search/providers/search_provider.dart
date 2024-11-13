import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

enum Sort { posts, exits, views /* likes, top_posts */ }

class SearchProvider extends ChangeNotifier {
  // final controller = ScrollController();
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

  Sort _sort = Sort.posts;
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
    Sort.posts: 'Vible',
    Sort.exits: 'Top Exited',
    Sort.views: 'Top Viewed',
  };

  String get sortDisplayName {
    switch (_sort) {
      case Sort.posts:
        return 'Vible';
      case Sort.exits:
        return 'Top Exited';
      case Sort.views:
        return 'Top Viewed';
      default:
        return 'Vible';
    }
  }

  Future<void> _fetchMoreContent() async {
    _isFetching = true;
    _posts_page++;
    // log('page: $_posts_page');
    try {
      switch (_sort) {
        case Sort.posts:
          await getSubversePosts(id: subverse_id);
          break;
        case Sort.exits:
          await getPostsByExitCount(id: subverse_id);
          break;
        case Sort.views:
          await getPostsByViewCount(id: subverse_id);
          break;
        default:
          await getSubversePosts(id: subverse_id);
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
      case Sort.posts:
        getSubversePosts(id: subverse_id, isRefresh: true);
        break;
      case Sort.exits:
        getPostsByExitCount(id: subverse_id, isRefresh: true);
        break;
      case Sort.views:
        getPostsByViewCount(id: subverse_id, isRefresh: true);
        break;
      default:
        getSubversePosts(id: subverse_id, isRefresh: true);
    }
  }

  List<Posts> get currentSortedPosts {
    switch (_sort) {
      case Sort.posts:
        return _posts;
      case Sort.exits:
        return _exits;
      case Sort.views:
        return _views;
      default:
        return _posts;
    }
  }

  set currentSortedPosts(List<Posts> value) {
    switch (_sort) {
      case Sort.posts:
        _posts = value;
        break;
      case Sort.exits:
        _exits = value;
        break;
      case Sort.views:
        _views = value;
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

  Future<void> getSubversePosts({required int id, bool? isRefresh}) async {
    isRefresh == true ? _posts.clear() : null;
    Response response = await _service.getSubversePosts(
      id: id,
      page: _posts_page,
    );
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
