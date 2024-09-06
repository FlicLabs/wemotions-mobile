import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/domain/models/single_post_model.dart';
import 'package:socialverse/features/home/widgets/home_video/pop_menu_slider.dart';

enum RateItem { LOVE_IT, LIKE_IT, OKAY, DISLIKE_IT, HATE_IT }

class HomeProvider extends ChangeNotifier {
  final home = PageController();
  final replies = PageController();
  final dynamicLink = DynamicLinkRepository();

  final _homeService = HomeService();
  final _subverseService = SubverseService();

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

  int _horizontalIndex = 0;
  int get horizontalIndex => _horizontalIndex;

  set horizontalIndex(int value) {
    _horizontalIndex = value;
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

  /*
 hPosts store the current video with the replies for the horizontal feed.
  */
  List<Posts> _hPosts = <Posts>[];
  List<Posts> get hPosts => _hPosts;

  set hPosts(List<Posts> value) {
    _hPosts = value;
  }

  bool _fetchingReplies = false;
  bool get fetchingReplies => _fetchingReplies;

  set fetchingReplies(bool value) {
    _fetchingReplies = value;
    notifyListeners();
  }

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

  // Future<void> getFeed() async {
  //   Random random = Random();
  //   int randomNumber = random.nextInt(45) + 1;
  //   _page = randomNumber;
  //   await _homeService.getFeed(_page).then((response) {
  //     int randomNumber = random.nextInt(26) + 1;
  //     _page = randomNumber;
  //     addPostsToList(FeedModel.fromJson(response).posts);
  //   });
  //   notifyListeners();
  // }

  // void addPostsToList(List<Posts> postData) {
  //   _posts.addAll(postData);
  //   notifyListeners();
  // }

  Future<void> getSubversePosts({required int id, required int page}) async {
    _temp.clear();
    await _subverseService
        .getSubversePosts(id: id, page: page)
        .then((response) {
      addSubversePostsToList(SubverseModel.fromJson(response).posts);
      _subversePosts.addAll(_temp.toList());
    });
    notifyListeners();
  }

  void addSubversePostsToList(List<Posts> postData) {
    _temp.addAll(postData);
    notifyListeners();
  }

  Future<void> getSinglePost({required int id}) async {
    Response response = await _homeService.getSinglePost(id: id);
    if (response.statusCode == 200 && response.statusCode == 201) {
      final post = SinglePostModel.fromJson(response.data).post;
      _single_post.addAll(post);
      print(_single_post);
      notifyListeners();
    }
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
    horizontalIndex = 0;
    posts.clear();
    hPosts.clear();
    notifyListeners();

    await createIsolate(token: token);
    notifyListeners();

    fetchingReplies = true;
    await createReplyIsolate(posts[0], token: token);
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

  Future<void> showInspiredDialog(context, {required int id}) {
    return showDialog(
      context: context,
      builder: (context) {
        return InspiredDialog(id: id);
      },
    );
  }

  Future<void> showContextMenu(BuildContext context,
      {required id, required rate_value}) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    showMenu(
      context: context,
      color: Colors.transparent,
      elevation: 0,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 100, 100),
        Rect.fromLTWH(
          0,
          50,
          overlay!.paintBounds.size.width,
          overlay.paintBounds.size.height,
        ),
      ),
      items: [
        PopupMenuSlider(
          rate_value: rate_value.toDouble(),
          id: id,
        ),
      ],
    );
  }

  void getTapPosition(BuildContext context, TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    notifyListeners();
    print(_tapPosition);
  }

  Future<void> browseSubverse({
    required BuildContext context,
    required category_name,
    required category_desc,
    required category_count,
    required category_id,
    required category_photo,
    Function()? callBack,
  }) async {
    await getSubversePosts(id: category_id, page: subverse_page);
    if (_subversePosts.isEmpty) {
      Navigator.of(context).pushNamed(
        SubverseEmptyScreen.routeName,
        arguments: SubverseEmptyScreenArgs(
          category_name: category_name,
          category_desc: category_desc,
          category_count: category_count,
          category_id: category_id,
          fromVideoPlayer: false,
          category_photo: category_photo,
        ),
      );
    } else {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          Navigator.of(context)
              .pushNamed(
                SubverseDetailScreen.routeName,
                arguments: SubverseDetailScreenArgs(
                  category_name: category_name,
                  category_desc: category_desc,
                  category_count: category_count,
                  category_id: category_id,
                  fromVideoPlayer: false,
                  category_photo: category_photo,
                ),
              )
              .then((value) => callBack!());
        },
      );
    }
  }

  final Map<String, VideoPlayerController> _controllers = {};
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
    _controllers[posts.elementAt(index).videoLink] = controller;
    await controller.initialize();
  }

  void setPlaybackSpeed(double speed) {
    _playback_speed = speed;
    _controllers.values.forEach((controller) {
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
    return _controllers[posts.elementAt(index).videoLink] ??
        _controllers[API.video_link];
  }

  void disposed(index) {
    videoController(index)?.dispose();
    _controllers.remove(posts.elementAt(index));
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

  Future<void> _autoScroll(index) async {
    _isPlaying = true;
    posts_page++;
    createIsolate(token: token);
    notifyListeners();

    int newIndex = index;
    newIndex++;
    // print("new index $newIndex");
    // print("index $index");
    animateToPage(newIndex);
    _stopController(index);
    _index = newIndex;
    notifyListeners();
    // print("_index $_index");

    if (_index < index) {
      // print("_index $_index < index $index");
      if (_index == posts.length - 1) {
        return;
      }

      print("_index $index");

      if (_index - 1 >= 0) {
        _removeController(_index - 1);
      }
      _playController(_index);
      if (_index == posts.length - 1) {
      } else {
        _initController(_index + 1);
      }
      notifyListeners();
    } else {
      if (_index == 0) {
        _controllers.forEach((key, value) {});
        return;
      }
      _stopController(_index);
      if (_index + 1 < posts.length) {
        _removeController(_index + 1);
      }
      _playController(--_index);
      if (_index == 0) {
      } else {
        _initController(_index - 1);
      }
    }
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
      _controllers.forEach((key, value) {});
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
    _controllers.remove(posts.elementAt(index));
    _listeners.remove(index);
  }

  onPageChanged(int index) async {
    _isPlaying = true;
    createIsolate(token: token);
    // createReplyIsolate(_posts[index]);
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

  Future createIsolate({String? token}) async {
    ReceivePort mainReceivePort = ReceivePort();
    /* 
       ReceivePort is a communication channel for receiving messages.
       Here, we create a new ReceivePort called mainReceivePort, 
       which will be used to receive messages from the spawned isolate. 
    */
    Isolate.spawn<SendPort>(getVideosTask, mainReceivePort.sendPort);
    /* 
       Isolate.spawn is used to create a new isolate. It takes two arguments:
       the function (getVideosTask) to be executed in the isolate, and the SendPort 
       (mainReceivePort.sendPort) through which the isolate can send messages back to the main isolate.
    */
    SendPort isolateSendPort = await mainReceivePort.first;
    /* 
       await mainReceivePort.first waits for the first message to be received on 
       the mainReceivePort. In this case, it waits for the SendPort of the spawned
       isolate to be received and assigns it to isolateSendPort.
    */
    ReceivePort isolateResponseReceivePort = ReceivePort();
    /* 
       Another ReceivePort called isolateResponseReceivePort is created. 
       This port will be used to receive the response from the spawned isolate.
    */

    isolateSendPort
        .send([_posts_page, isolateResponseReceivePort.sendPort, token]);
    /* 
       The _posts_page and isolateResponseReceivePort.sendPort are sent 
       to the spawned isolate through isolateSendPort. This is done by sending a 
       list containing these values.
    */

    final isolateResponse = await isolateResponseReceivePort.first;
    _posts.addAll(isolateResponse.toList());
    notifyListeners();
    /* 
       await isolateResponseReceivePort.first waits for the first message to be 
       received on isolateResponseReceivePort. Once received, it assigns the 
       message to isolateResponse, which is then added to the _posts list.
    */
  }

  static void getVideosTask(SendPort mySendPort) async {
    final _homeService = HomeService();
    ReceivePort isolateReceivePort = ReceivePort();
    /* 
       In the spawned isolate, a new ReceivePort called isolateReceivePort is 
       created. This will be used to receive messages from the main isolate.
    */
    mySendPort.send(isolateReceivePort.sendPort);
    /* 
       The SendPort of the spawned isolate's isolateReceivePort is sent back to 
       the main isolate through mySendPort. This allows the main isolate to send 
       messages to the spawned isolate.
    */

    await for (var message in isolateReceivePort) {
      if (message is List) {
        final int index = message[0];
        final SendPort isolateResponseSendPort = message[1];
        final token = message[2];
        /* 
       The isolateReceivePort listens for incoming messages in a loop using a
       for loop. It waits for messages to be received on isolateReceivePort.
    */
        /* 
       If the received message is a List, it extracts the index and 
       isolateResponseSendPort from the message.
    */
        // final _service = SubverseService();

        final response = await _homeService.getFeed(index, token ?? '');
        final List<Posts> data = FeedModel.fromJson(response).posts;
        isolateResponseSendPort.send(data);

        /* 
       A network request is made to retrieve video data based on the index value
       received. The response is converted into a FeedModel object, and the posts list is extracted.
    */
        /* 
       The isolateResponseSendPort is then used to send the data (video posts) back to the main isolate.
    */
      }
    }
  }

  /* 
       In summary, this code sets up a communication mechanism using SendPort and 
       ReceivePort to create a separate isolate that retrieves video data. The spawned 
       isolate receives a random number from the main isolate, makes a network request 
       based on that number, and sends the retrieved video posts back to the main isolate. 
       This allows the main isolate to continue its execution without being blocked by the 
       network request, resulting in faster and more efficient video playback
  */

  // Isolate to fetch the replies of the current video using post id

  Future createReplyIsolate(Posts post, {String? token}) async {
    ReceivePort mainReceivePort = ReceivePort();

    Isolate.spawn<SendPort>(getRepliesTask, mainReceivePort.sendPort);

    SendPort isolateSendPort = await mainReceivePort.first;

    ReceivePort isolateResponseReceivePort = ReceivePort();

    isolateSendPort.send([post.id, isolateResponseReceivePort.sendPort, token]);

    final isolateResponse = await isolateResponseReceivePort.first;
    _hPosts.clear();
    _hPosts.addAll(isolateResponse.toList());
    fetchingReplies = false;
    notifyListeners();
  }

  static void getRepliesTask(SendPort mySendPort) async {
    final _homeService = HomeService();
    ReceivePort isolateReceivePort = ReceivePort();

    mySendPort.send(isolateReceivePort.sendPort);

    await for (var message in isolateReceivePort) {
      if (message is List) {
        final int index = message[0];
        final SendPort isolateResponseSendPort = message[1];
        final token = message[2];

        final response = await _homeService.getReplies(index, token ?? '');
        final List<Posts> data = ReplyModel.fromJson(response).post;
        isolateResponseSendPort.send(data);
      }
    }
  }
}
