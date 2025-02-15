import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import for ChangeNotifier
import 'package:socialverse/export.dart';
import 'package:video_player/video_player.dart'; // Explicit import

class ReplyProvider extends ChangeNotifier {
  // Services
  final HomeService _homeService = HomeService();
  final SubverseService _subverseService = SubverseService();

  // Controllers
  final PageController home = PageController();
  final Map<String, VideoPlayerController> _videoControllers = {};
  final Map<int, VoidCallback> _videoListeners = {};

  // State Variables
  int page = 1;
  int postsPage = 1;
  int subversePage = 1;
  int index = 0;
  double playbackSpeed = 1.0;
  double sliderValue = 0;
  bool isPlaying = true;
  bool isAutoScroll = false;
  bool isSlider = false;
  bool isRefreshing = false;
  bool isFollowing = false;
  bool subscribed = false;
  bool isLoading = false;
  bool isLiked = false;
  double likeAnimationScale = 1.0;
  int consecutiveDoubleTaps = 0;
  Offset tapPosition = Offset.zero;
  Offset? prevTapPosition = Offset.zero;
  bool isTextExpanded = false;
  double expansionProgress = 0;
  bool didScroll = false; // Add this if needed

  // Data Lists
  List<Posts> posts = [];
  List<Posts> singlePost = [];
  List<Posts> subversePosts = [];
  List<Posts> tempPosts = [];


  // Timers
  Timer? _debounceTimer; // If you need it
  Timer? _expansionTimer;

  // Getters and setters (for all properties) ...

  // Methods

  Future<void> getSubversePosts({required int id, required int page}) async {
    tempPosts.clear();
    isLoading = true; // Set loading state
    notifyListeners();
    try {
      final response = await _subverseService.getSubversePosts(page: page);
      final newPosts = SubverseModel.fromJson(response).posts;
      tempPosts.addAll(newPosts);
      subversePosts.addAll(tempPosts);
    } catch (e) {
      print('Error fetching subverse posts: $e');
      // Handle error (e.g., show a snackbar)
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ... (getSinglePost, updateViewCount, etc.)

  Future<void> onRefresh() async {
    isRefreshing = true;
    notifyListeners();
    try {
      posts.clear();
      postsPage = 1;
      index = 0; // Reset index on refresh
      await initializeVideoPlayer(); // Re-initialize videos

    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }

  // ... (postLikeAdd, deletePost, etc.)

  // Video Player Management (Improved)

  Future<void> initializeVideoPlayer() async {
    if (posts.isNotEmpty) {
      index = 0;
      isPlaying = true;
      await _initController(0);
      _playController(0);

      if (posts.length > 1) {
        await _initController(1); // Initialize the next video
      }
    }
  }


  Future<void> _initController(int index) async {
    if (index < 0 || index >= posts.length) return; // Check index range
    final post = posts.elementAt(index);
    if (_videoControllers.containsKey(post.videoLink)) return; // Already initialized

    final controller = VideoPlayerController.network(
      post.videoLink,
      videoPlayerOptions: const VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );

    _videoControllers[post.videoLink] = controller;
    _videoListeners[index] = _listenerSpawner(index);

    try {
      await controller.initialize();
      notifyListeners(); // Notify after successful initialization
    } catch (e) {
      print('Error initializing video $index: $e');
      // Handle error (e.g., show an error message to the user)
      _videoControllers.remove(post.videoLink); // Remove the failed controller
      _videoListeners.remove(index);
      notifyListeners();
    }
  }

  void _playController(int index) async {
      if (index < 0 || index >= posts.length) return; // Check index range
      final post = posts.elementAt(index);
      final controller = _videoControllers[post.videoLink];

      if (controller != null) {
        controller.addListener(_videoListeners[index]!);
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
     if (index < 0 || index >= posts.length) return null; // Check index range
    final post = posts.elementAt(index);
    return _videoControllers[post.videoLink];
  }

  void disposeVideoController(int index) {
    if (index < 0 || index >= posts.length) return; // Check index range
    final post = posts.elementAt(index);
    final controller = _videoControllers[post.videoLink];
    if (controller != null) {
      controller.removeListener(_videoListeners[index]!);
      controller.dispose();
      _videoControllers.remove(post.videoLink);
      _videoListeners.remove(index);
    }
  }


  VoidCallback _listenerSpawner(int index) {
     return () {
      final controller = videoController(index);
      if (controller == null) return;

      if (controller.value.hasError) {
        print(controller.value.errorDescription ?? '');
        // Handle error (e.g., show a snackbar)
      }

      if (controller.value.isInitialized) {
        final position = controller.value.position;
        final duration = controller.value.duration;

        if (position != null && duration != null) {
          final positionInMilliseconds = position.inMilliseconds;
          final durationInMilliseconds = duration.inMilliseconds;
          final timeRemaining = durationInMilliseconds - positionInMilliseconds;


          if (durationInMilliseconds < 1) return;

          if (positionInMilliseconds > 1 && !_viewCountUpdated.containsKey(index) && logged_in!) {
            updateViewCount(id: posts.elementAt(index).id);
            _viewCountUpdated[index] = true;
          }

          if (timeRemaining <= 400) {  // Slightly more lenient for end detection
            _viewCountUpdated.remove(index); // Reset view count
            _autoScroll(index);
          }
        }
      }
      notifyListeners();
    };
  }



  Future<void> _autoScroll(int index) async {
    _isPlaying = true;
    postsPage++;
    notifyListeners();

    int newIndex = index + 1;

    if (newIndex < posts.length) { // Check if newIndex is within bounds
      animateToPage(newIndex);
      _stopController(index);
      this.index = newIndex;
      _playController(newIndex);
      _initController(newIndex + 1); // Initialize the next video
      notifyListeners();
    }
  }


  Future<void> _nextVideo() async {
    if (index < posts.length - 1) {
      _stopController(index);
      _removeController(index -1); //Remove previous controller
      _playController(++index);
      _initController(index + 1); // Initialize the next video
      notifyListeners();
    }
  }

  Future<void> _previousVideo() async {
    if (index > 0) {
      _stopController(index);
      _removeController(index + 1); //Remove next controller
      _playController(--index);
      _initController(index - 1); // Initialize the previous video
      notifyListeners();

    }
  }



  void _stopController(int index) {
    if (index < 0 || index >= posts.length) return;
    if (_videoListeners[index] != null) {
      videoController(index)?.removeListener(_videoListeners[index]!);
    }
    videoController(index)?.pause();
    videoController(index)?.seekTo(Duration.zero);
  }

  void _removeController(int index) {
    if (index < 0 || index >= posts.length) return;
    disposeVideoController(index); // Use the dedicated dispose method
  }

  onPageChanged(int index) async {
    _isPlaying = true;

    if (index >= 0 && index < posts.length) { // Check index range
      HomeWidget.saveWidgetData<String>('title', posts[index].title);
      HomeWidget.saveWidgetData<String>('description', posts[index].username);
      HomeWidget.saveWidgetData<String>('image', posts[index].thumbnailUrl);
      HomeWidget.updateWidget(
        iOSName: iOSWidgetName,
        androidName: androidWidgetName,
      );
    }

    notifyListeners();

    if (this.index > index) {
      await _previousVideo();
    } else if (this.index < index) {
      await _nextVideo();
    }
    this.index = index;
    notifyListeners();
  }


  @override
  void dispose() {
    home.dispose();
    _videoControllers.forEach((key, controller) {
      controller.dispose();
    });
    _videoControllers.clear();
    _videoListeners.clear();
    _debounceTimer?.cancel();
    _expansionTimer?.cancel();
    super.dispose();
  }
}
