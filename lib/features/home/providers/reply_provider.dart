import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

/* New provider to manage the horizontal feed and their video controllers.*/

class ReplyProvider extends ChangeNotifier {
  final home = PageController();

  final _homeService = HomeService();

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  bool _isAutoScroll = false;
  bool get isAutoScroll => _isAutoScroll;

  set isAutoScroll(bool value) {
    _isAutoScroll = value;
    notifyListeners();
  }

  bool _isSlider = false;
  bool get isSlider => _isSlider;

  set isSlider(bool value) {
    _isSlider = value;
    notifyListeners();
  }

  int _posts_page = 1;
  int get posts_page => _posts_page;

  set posts_page(int value) {
    _posts_page = value;
    notifyListeners();
  }

  double _playback_speed = 1.0;
  double get playback_speed => _playback_speed;

  set playback_speed(double value) {
    _playback_speed = value;
    notifyListeners();
  }

  Offset _tapPosition = Offset.zero;
  Offset get tapPosition => _tapPosition;

  set tapPosition(Offset value) {
    _tapPosition = value;
    notifyListeners();
  }

  void setTapPosition(Offset position) {
    _tapPosition = position;
    notifyListeners();
  }

  int _subverse_page = 1;
  int get subverse_page => _subverse_page;

  set subverse_page(int value) {
    _subverse_page = value;
    notifyListeners();
  }

  animateToPage(index) {
    home.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  int _index = 0;
  int get index => _index;

  set index(int value) {
    _index = value;
    notifyListeners();
  }


  bool _didScroll = false;
  bool get didScroll => _didScroll;

  set didScroll(bool value) {
    _didScroll = value;
    notifyListeners();
  }

  double _slider_val = 0;
  double get slider_val => _slider_val;

  set slider_val(double value) {
    _slider_val = value;
    notifyListeners();
  }

  bool _isPlaying = true;
  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  set isFollowing(bool value) {
    _isFollowing = value;
    notifyListeners();
  }

  bool _subscribed = false;
  bool get subscribed => _subscribed;

  set subscribed(bool value) {
    _subscribed = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  set isLiked(bool value) {
    _isLiked = value;
    notifyListeners();
  }

  double _likeAnimationScale = 1.0;
  double get likeAnimationScale => _likeAnimationScale;

  set likeAnimationScale(double value) {
    _likeAnimationScale = value;
    notifyListeners();
  }

  int _consecutiveDoubleTaps = 0;
  int get consecutiveDoubleTaps => _consecutiveDoubleTaps;

  set consecutiveDoubleTaps(int value) {
    _consecutiveDoubleTaps = value;
    notifyListeners();
  }

  Timer? _timer;
  Timer? get timer => _timer;

  set timer(Timer? value) {
    _timer = value;
    notifyListeners();
  }

  Offset? _prevTapPosition = Offset.zero;
  Offset? get prevTapPosition => _prevTapPosition;

  set prevTapPosition(Offset? value) {
    _prevTapPosition = value;
    notifyListeners();
  }

  void handleDoubleTap() {
    _isLiked = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 1), () {
      // _isLiked = false;
      // notifyListeners();
    });
  }

  List<Posts> _posts = <Posts>[];
  List<Posts> get posts => _posts;

  set posts(List<Posts> value) {
    _posts = value;
  }

  // List<Posts> _replies = <Posts>[];
  // List<Posts> get replies => _replies;
  //
  // set replies(List<Posts> value) {
  //   _replies = value;
  // }

  List<Posts> _single_post = <Posts>[];
  List<Posts> get single_post => _single_post;

  set single_post(List<Posts> value) {
    _single_post = value;
  }

  List<Posts> _subversePosts = <Posts>[];
  List<Posts> get subversePosts => _subversePosts;

  List<Posts> _temp = <Posts>[];
  List<Posts> get temp => _temp;

  bool _isTextExpanded = false;
  bool get isTextExpanded => _isTextExpanded;

  void toggleTextExpanded() {
    _isTextExpanded = !_isTextExpanded;
    _animateTextExpansion();
    notifyListeners();
  }

  double _expansionProgress = 0;
  double get expansionProgress => _expansionProgress;

  void _animateTextExpansion() {
    const stepDuration = Duration(milliseconds: 20);
    const steps = 5;
    int currentStep = 0;

    Timer.periodic(stepDuration, (timer) {
      _expansionProgress =
          _isTextExpanded ? (currentStep / steps) : 1 - (currentStep / steps);
      notifyListeners();
      currentStep++;

      if (currentStep > steps) {
        timer.cancel();
      }
    });
  }

  void handleVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      print('Swiping up');
      HapticFeedback.mediumImpact();
    } else if (details.delta.dy > 0) {
      print('Swiping down');
      HapticFeedback.mediumImpact();
    }
  }


  void addSubversePostsToList(List<Posts> postData) {
    _temp.addAll(postData);
    notifyListeners();
  }


  Future<void> updateViewCount({required int id}) async {
    Map data = {
      "post_id": id,
    };
    await _homeService.view(data: data);
    notifyListeners();
  }

  Future<void> updateExitCount({required int id}) async {
    Map data = {
      "post_id": id,
    };
    print(data);
    await _homeService.inspire(data: data);
    notifyListeners();
  }

  Future<void> updateRating({required int id, required int rating}) async {
    Map data = {
      "post_id": id,
      "rating": rating,
    };
    print(data);
    await _homeService.rating(data: data);
    notifyListeners();
  }

  Future<void> onRefresh() async {
    HapticFeedback.mediumImpact();
    posts.isEmpty ? null : disposed(_index);
    posts_page = 1;
    posts.clear();
    notifyListeners();
  }

  Future<void> postLikeAdd({required int id}) async {
    await _homeService.postLikeAdd(id);
  }

  Future<void> postLikeRemove({required int id}) async {
    await _homeService.postLikeRemove(id);
  }

  Future<dynamic> deletePost({required int id}) async {
    final response = await _homeService.deletePost(id);
    if (response == 200 || response == 201) {
      return response;
    }
  }

  Future<void> blockPost({required int id}) async {
    await _homeService.blockPost(id);
  }

  Future<void> unblockPost({required int id}) async {
    await _homeService.unblockPost(id);
  }

  Future<dynamic> deletePostAdmin({required int id}) async {
    final response = await _homeService.deletePostAdmin(id);
    if (response == 200 || response == 201) {
      return response;
    }
  }



  void getTapPosition(BuildContext context, TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    notifyListeners();
    print(_tapPosition);
  }

  final Map<String, VideoPlayerController> controllers = {};
  final Map<int, VoidCallback> _listeners = {};
  final Map<int, bool> _viewCountUpdated = {};

  initializedVideoPlayer() async {
    if (posts.isNotEmpty) {
      _index = 0;
      _isPlaying = true;
      _initController(0).then((_) {
        _playController(0);
      });
    }
    if (posts.length > 1) {
      _initController(1);
    }
  }

  Future<void> _initController(int index) async {
    var controller = VideoPlayerController.network(
      posts.elementAt(index).videoLink,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );
    _viewCountUpdated[index] = false;
    controllers[posts.elementAt(index).videoLink] = controller;
    await controller.initialize();
  }

  void setPlaybackSpeed(double speed) {
    _playback_speed = speed;
    controllers.values.forEach((controller) {
      controller.setPlaybackSpeed(speed);
    });
    notifyListeners();
  }

  void _playController(
    int index,
    /* int bottomNavIndex */
  ) async {
    if (!_listeners.keys.contains(index)) {
      _listeners[index] = _listenerSpawner(index);
    }
    videoController(index)?.addListener(_listeners[index]!);
    if (_isPlaying /* && bottomNavIndex == 0 */) {
      await videoController(index)?.play();
      await videoController(index)?.setLooping(true);
    } else {
      await videoController(index)?.pause();
      await videoController(index)?.setLooping(true);
    }
    _isPlaying = true;
    notifyListeners();
  }

  VideoPlayerController? videoController(int index) {
    return controllers[posts.elementAt(index).videoLink] ??
        controllers[API.video_link];
  }

  void disposed(index) {
    videoController(index)?.dispose();
    controllers.remove(posts.elementAt(index));
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      final controller = videoController(index);

      if (controller?.value.hasError == true) {
        // Handle errors here, e.g., show a snackbar
        print(controller?.value.errorDescription ?? '');
      }
      if (controller?.value.isInitialized == true) {
        // _nextAutoVideo();
        // print("Video initialized $index");
        final position = controller?.value.position;
        final duration = controller?.value.duration;

        // print("Video initialized $position");
        // print("Video initialized $duration");

        if (position != null && duration != null) {
          // Use a small range to account for floating-point precision
          final positionInSeconds = position.inMilliseconds;
          final durationInSeconds = duration.inMilliseconds;
          final positionDifference = durationInSeconds - positionInSeconds;

          if (durationInSeconds < 1) {
            return;
          }

          if (positionInSeconds > 1) {
            if (positionInSeconds > 1 &&
                !_viewCountUpdated[index]! &&
                logged_in!) {
              updateViewCount(id: posts.elementAt(index).id);
              _viewCountUpdated[index] = true;
            }
          }

          if (positionDifference <= 0.4) {
            // Video playback is near or at the end, move to the next video
            // print("Video playback ended for index $index");
            _viewCountUpdated[index] = false;
            // _isAutoScroll ? _autoScroll(index) : null;
          }
        }
      }
      notifyListeners();
    };
  }


  Future<void> _nextVideo() async {
    if (_index == posts.length - 1) {
      return;
    }
    _stopController(_index);
    if (_index - 1 >= 0) {
      _removeController(_index - 1);
    }
    _playController(
      ++_index,
    );
    if (_index == posts.length - 1) {
    } else {
      _initController(_index + 1);
    }
  }

  Future<void> removeController(index) async {
    if (index == posts.length - 1) {
      return;
    }
    _stopController(index);
    if (index - 1 >= 0) {
      _removeController(index - 1);
    }
    _playController(
      ++index,
    );
    if (index == posts.length - 1) {
    } else {
      _initController(index + 1);
    }
  }

  Future<void> _previousVideo() async {
    if (_index == 0) {
      controllers.forEach((key, value) {});
      return;
    }
    _stopController(_index);
    if (_index + 1 < posts.length) {
      _removeController(_index + 1);
    }
    _playController(
      --_index,
    );
    if (_index == 0) {
    } else {
      _initController(_index - 1);
    }
  }

  void _stopController(int index) {
    if (_listeners[index] != null) {
      videoController(index)?.removeListener(_listeners[index]!);
    }
    videoController(index)?.pause();
    videoController(index)?.seekTo(const Duration(milliseconds: 0));
  }

  void _removeController(int index) {
    videoController(index)?.dispose();
    controllers.remove(posts.elementAt(index));
    _listeners.remove(index);
  }

  onPageChanged(int index) async {
    _isPlaying = true;
    // createIsolate(token: token);
    HomeWidget.saveWidgetData<String>('title', _posts[index].title);
    HomeWidget.saveWidgetData<String>('description', _posts[index].username);
    HomeWidget.saveWidgetData<String>('image', _posts[index].thumbnailUrl);
    HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: androidWidgetName,
    );
    notifyListeners();
    if (_index > index) {
      await _previousVideo();
      _index = index;
      notifyListeners();
    } else {
      await _nextVideo();
      _index = index;
      notifyListeners();
    }
    notifyListeners();
  }
}
