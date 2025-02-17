import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import for ChangeNotifier
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/domain/models/voting_model.dart';
import 'package:video_player/video_player.dart'; // Explicit import

enum RateItem { loveIt, likeIt, okay, dislikeIt, hateIt }

class HomeProvider extends ChangeNotifier {
  // Services
  final HomeService _homeService = HomeService();
  final SubverseService _subverseService = SubverseService();

  // Controllers
  final PageController home = PageController();
  final PageController replies = PageController();
  final Map<String, VideoPlayerController> _videoControllers = {};
  final Map<int, VoidCallback> _videoListeners = {};
  final TextEditingController searchController = TextEditingController();

  // State Variables
  int page = 1;
  int postsPage = 1;
  int subversePage = 1;
  int index = 0;
  int horizontalIndex = 0;
  double playbackSpeed = 1.0;
  double sliderValue = 0;
  bool isPlaying = true;
  bool isAutoScroll = false;
  bool isSlider = false;
  bool isRefreshing = false;
  bool isFollowing = false;
  bool subscribed = false;
  bool isLoading = false; // Renamed for clarity
  bool isLiked = false;
  double likeAnimationScale = 1.0;
  int consecutiveDoubleTaps = 0;
  Offset tapPosition = Offset.zero;
  Offset? prevTapPosition = Offset.zero;
  bool isTextExpanded = false;
  double expansionProgress = 0;
  bool fetchingReplies = false;

  // Data Lists
  List<List<Posts>> posts = [];
  List<Posts> singlePost = [];
  List<Posts> subversePosts = [];
  List<Posts> tempPosts = []; // More descriptive name
  List<VotingModel> votings = [];
  List<UserSearchModel> searchedUsers = [];
  List<UserSearchModel> selectedUsers = [];

  // Timers
  Timer? _debounceTimer;
  Timer? _expansionTimer;


  // ... (Getters and setters for all the above properties)

  // Methods

  // ... (animateToPage, handleVerticalDragUpdate, etc.)

  Future<void> getSubversePosts({required int id, required int page}) async {
    tempPosts.clear(); // Clear before adding new data
    try {
      final response = await _subverseService.getSubversePosts(page: page);
      final newPosts = SubverseModel.fromJson(response).posts;
      tempPosts.addAll(newPosts);
      subversePosts.addAll(tempPosts); // Combine lists efficiently
    } catch (e) {
      // Handle error (e.g., show a snackbar)
      print('Error fetching subverse posts: $e');
    } finally {
      notifyListeners();
    }
  }

  // ... (getSinglePost, updateViewCount, etc.)

  Future<void> onRefresh() async {
    isRefreshing = true; // Set refreshing state
    notifyListeners(); // Notify before starting refresh

    try {
        posts.clear();
        postsPage = 1;
        horizontalIndex = 0;
        await Future.wait([
          createIsolate(token: token),
          createReplyIsolate(0, token: token),
        ]);
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }


  // ... (postLikeAdd, deletePost, showContextMenu, etc.)

  // Video Player Management (Improved)

  Future<void> initializeVideoPlayer() async {
    if (posts.isNotEmpty) {
      index = 0;
      isPlaying = true;
      await _initController(0);
      _playController(0);

      if (posts.length > 1) {
        await _initController(1); // Initialize next video
      }
    }
  }

  Future<void> _initController(int index) async {
    final post = posts.elementAt(index)[0]; // Get the post
    if (_videoControllers.containsKey(post.videoLink)) return; // Already initialized

    final controller = VideoPlayerController.network(
      post.videoLink,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );

    _videoControllers[post.videoLink] = controller; // Use videoLink as key
    _videoListeners[index] = _listenerSpawner(index); // Store the listener

    try {
      await controller.initialize();
    } catch (e) {
      print('Error initializing video: $e');
      // Handle error (e.g., show error message)
    }

    notifyListeners(); // Notify after initialization
  }

  void _playController(int index) async {
    final post = posts.elementAt(index)[0];
    final controller = _videoControllers[post.videoLink];

    if (controller != null) {
      controller.addListener(_videoListeners[index]!); // Add listener
      if (isPlaying) {
        await controller.play();
        await controller.setLooping(true);
      } else {
        await controller.pause();
      }
    }
    notifyListeners();
  }

  VideoPlayerController? videoController(int index) {
    final post = posts.elementAt(index)[0];
    return _videoControllers[post.videoLink];
  }

  void disposeVideoController(int index) {
      final post = posts.elementAt(index)[0];
      final controller = _videoControllers[post.videoLink];
      if(controller != null){
        controller.removeListener(_videoListeners[index]!);
        controller.dispose();
        _videoControllers.remove(post.videoLink);
        _videoListeners.remove(index);
      }
  }


  VoidCallback _listenerSpawner(int index) {
    return () {
      final controller = videoController(index);
      if (controller == null) return; // Handle null controller

      if (controller.value.hasError) {
        print(controller.value.errorDescription ?? '');
        // Handle error
      }

      if (controller.value.isInitialized) {
        final position = controller.value.position;
        final duration = controller.value.duration;

        if (position != null && duration != null) {
          final positionInSeconds = position.inMilliseconds;
          final durationInSeconds = duration.inMilliseconds;
          final positionDifference = durationInSeconds - positionInSeconds;

          if (durationInSeconds < 1) return; // Avoid division by zero

          if (positionInSeconds > 1 && !_viewCountUpdated.containsKey(index) && logged_in!) {
            updateViewCount(id: posts.elementAt(index)[0].id);
            _viewCountUpdated[index] = true;
          }

          if (positionDifference <= 400) { // More lenient for end detection
            _viewCountUpdated.remove(index); // Reset view count update
            _autoScroll(index);
          }
        }
      }
      notifyListeners();
    };
  }

  // ... (_autoScroll, _nextVideo, _previousVideo, onPageChanged, etc.)

  // Isolates (Improved)

  Future<void> createIsolate({String? token}) async {
    // ... (Isolate code remains largely the same, but handle errors)
  }

  static void getVideosTask(SendPort mySendPort) async {
    // ... (Isolate task code remains largely the same)
  }

  Future<void> createReplyIsolate(int indexForFetch, {String? token}) async {
    // ... (Isolate code remains largely the same, but handle errors)
  }

  static void getRepliesTask(SendPort mySendPort) async {
    // ... (Isolate task code remains largely the same)
  }

  // ... (Voting and Tagging features - largely the same, but handle errors)

  // Text Expansion Animation (Improved)
  void toggleTextExpanded() {
    isTextExpanded = !isTextExpanded;

    _expansionTimer?.cancel(); // Cancel any existing timer
    _expansionTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      expansionProgress = isTextExpanded ? timer.tick / 5 : 1 - (timer.tick / 5);
      notifyListeners();
      if (timer.tick >= 5) {
        timer.cancel();
        _expansionTimer = null;
      }
    });
  }

  // ... (Rest of the methods)

  @override
  void dispose() {
    home.dispose();
    replies.dispose();
    searchController.dispose();
    _debounceTimer?.cancel();
    _expansionTimer?.cancel();
    _videoControllers.forEach((key, controller) {
      controller.dispose();
    });
    _videoControllers.clear();
    _videoListeners.clear();
    super.dispose();
  }
}
