import 'dart:isolate';

import 'package:socialverse/export.dart';
//
// class NestedReply with ChangeNotifier{
//
// //=========================Nested Reply=============================
//
//   final Map<String, VideoPlayerController> _nestedRControllers = {};
//   final Map<int, VoidCallback> _nestedRListeners = {}; // takes postId as int
//   final Map<int, bool> _nestedRViewCountUpdated = {};  // takes postId as int
//
//
//   int _hNReply = 0;
//   int _vNReply = 0;
//   bool _vScrollReply=true; // track even or odd scroll
//
//   int _currIndex=0;
//
//   List<Posts> _postsTrack = [];
//   List<int> _currIndexTrack = [];
//   List<List<Posts>> _hPosts=[];
//   List<List<Posts>> _vPosts=[];
//
//   bool _isPlaying= false;
//   bool _fetchingReplies=false;
//   bool _canFetchReplies = false;
//
//
//   initializeRVideoPlayer(bool isVertical) async {
//     var _posts = isVertical?_vPosts[_vNReply]:_hPosts[_hNReply];
//       _currIndex=0;
//       _currIndexTrack.add(_currIndex);
//
//       if (_posts.isNotEmpty) {
//         _isPlaying = true;
//         await _initController(0,isVertical);
//       }
//       if (_posts.length > 1) {
//         await _initController(1,isVertical);
//       }
//       if (_posts.length > 2) {
//         await _initController(2,isVertical);
//       }
//
//
//   }
//
//
//   VideoPlayerController? videoController(int index, bool isVertical) {
//     var _posts= isVertical?_vPosts[_vNReply]:_hPosts[_hNReply];
//     if (_posts.isEmpty || index < 0 || index >= _posts.length) {
//       return null;
//     }
//     return _nestedRControllers[_posts.elementAt(index).videoLink];
//   }
//
//   VoidCallback _listenerSpawner(index, bool isVertical) {
//     var _posts= isVertical?_vPosts[_vNReply]:_hPosts[_hNReply];
//     return () {
//
//       final controller = videoController(index,isVertical);
//
//       if (controller?.value.hasError == true) {
//         // Handle errors here, e.g., show a snackbar
//         print(controller?.value.errorDescription ?? '');
//       }
//       if (controller?.value.isInitialized == true) {
//         // _nextAutoVideo();
//         // print("Video initialized $index");
//         final position = controller?.value.position;
//         final duration = controller?.value.duration;
//
//         // print("Video initialized $position");
//         // print("Video initialized $duration");
//
//         if (position != null && duration != null) {
//           // Use a small range to account for floating-point precision
//           final positionInSeconds = position.inMilliseconds;
//           final durationInSeconds = duration.inMilliseconds;
//           final positionDifference = durationInSeconds - positionInSeconds;
//
//           if (durationInSeconds < 1) {
//             return;
//           }
//
//           if (positionInSeconds > 1) {
//             if (positionInSeconds > 1 &&
//                 !_viewCountUpdated[index]! &&
//                 logged_in!) {
//               updateViewCount(id: _posts.elementAt(index).id);
//               _viewCountUpdated[index] = true;
//             }
//           }
//
//           if (positionDifference <= 0.4) {
//             // Video playback is near or at the end, move to the next video
//             // print("Video playback ended for index $index");
//             _viewCountUpdated[index] = false;
//             // _isAutoScroll ? _autoScroll(index) : null;
//           }
//         }
//       }
//
//       notifyListeners();
//     };
//   }
//
//
//
//   // void _cleanupControllers(int currentIndex, bool isVertical) {
//   //   var _posts= isVertical? _vPosts[_vNReply]: _hPosts[_hNReply];
//   //   final keepRange = 2; // Range of controllers to keep on each side
//   //   final validIndices = <int>{};
//   //
//   //   // Calculate valid indices to keep
//   //   for (var i = currentIndex - keepRange; i <= currentIndex + keepRange; i++) {
//   //     if (i >= 0 && i < _posts.length) {
//   //       validIndices.add(i);
//   //     }
//   //   }
//   //
//   //   // Cleanup controllers outside the range
//   //   final linksToRemove = <String>[];
//   //   _nestedRControllers.forEach((videoLink, controller) {
//   //     bool shouldKeep = false;
//   //     for (var idx in validIndices) {
//   //       if (idx < _posts.length && _posts.elementAt(idx).videoLink == videoLink) {
//   //         shouldKeep = true;
//   //         break;
//   //       }
//   //     }
//   //     if (!shouldKeep) {
//   //       controller.pause();
//   //       controller.dispose();
//   //       linksToRemove.add(videoLink);
//   //
//   //       // Find and remove corresponding listener
//   //       _nestedRListeners.removeWhere((index, _) =>
//   //       index < 0 || index >= _posts.length || _posts.elementAt(index).videoLink == videoLink
//   //       );
//   //     }
//   //   });
//   //
//   //   linksToRemove.forEach(_nestedRControllers.remove);
//   // }
//
//
//   onPageChanged(int index,bool isVertical) async {
//     // print(_controllers.toString()+'|||||||||||||||||||||||||||||||||');
//     _isPlaying = true;
//     var _posts= isVertical? _vPosts[_vNReply]: _hPosts[_vNReply];
//
//
//     // Store old index before updating
//     final oldIndex = _currIndex;
//
//     // Important: Update index before video operations to ensure correct state
//     _currIndex = index;
//
//     // Initialize current video if not already initialized
//     if (!_nestedRControllers.containsKey(_posts.elementAt(index).videoLink)) {
//       await _initController(index,isVertical);
//     }
//
//     // Stop the current video first before any other operations
//     await _stopController(oldIndex,isVertical);
//
//     // Handle video playback in correct order
//     if (_vertical_drag_direction == -1) {
//       // Going up
//       await _previousVideo(isVertical);
//     } else if (_vertical_drag_direction == 1) {
//       // Going down
//       await _nextVideo(isVertical);
//     }
//
//
//     // Update vertical drag direction before any other operations
//     if (_vertical_drag_direction == 1) {
//       if (index + 1 < _posts.length) _initController(index + 1,isVertical);
//       if (index + 2 < _posts.length) _initController(index + 2,isVertical);
//     } else {
//       if (index - 1 >= 0) _initController(index - 1,isVertical);
//       if (index - 2 >= 0) _initController(index - 2,isVertical);
//     }
//
//     // Cleanup controllers outside the valid range
//     _cleanupControllers(index);
//
//     // unawaited(createReplyIsolate(token: token)
//     //     .then((_) => notifyListeners())
//     //     .catchError((e) => print("Error fetching new data: $e"))
//     // );
//
//
//     notifyListeners();
//   }
//
//
//
//   Future<void> disposeAllControllers() async{
//     _nestedRControllers.forEach((_, controller) async {
//       await controller.pause();
//       await controller.dispose();
//     });
//     _nestedRControllers.clear();
//     _nestedRListeners.clear();
//     _nestedRViewCountUpdated.clear();
//   }
//
//   Future<void> _previousVideo(bool isVertical) async {
//     // if (_index == 0){
//     //   // Make sure next video is stopped
//     //   await _stopController(_index + 1);
//     //
//     //   // Play current video
//     //   await _playController(_index);
//     //   return;
//     // }
//
//     // Initialize previous video if needed before any playback changes
//     if (_currIndex - 1 >= 0 && !_controllers.containsKey(posts.elementAt(_currIndex - 1)[0].videoLink)) {
//       unawaited(_initController(_currIndex - 1));  // Don't await here for faster playback
//     }
//
//     // Make sure next video is stopped
//     // await _stopController(_index + 1);
//
//     // Play current video
//     await _playController(_currIndex);
//
//     // // Cleanup old controllers
//     // if (_index + 3 < posts.length) {
//     //   _removeController(_index + 3);
//     // }
//   }
//
//   Future<void> _nextVideo(bool isVertical) async {
//     if (_currIndex == posts.length - 1) {
//       return;
//     }
//
//     // Initialize next video if needed before any playback changes
//     if (_currIndex + 1 < posts.length && !_controllers.containsKey(posts.elementAt(_currIndex + 1)[0].videoLink)) {
//       unawaited(_initController(_currIndex + 1));  // Don't await here for faster playback
//     }
//
//     // Make sure previous video is stopped
//     // await _stopController(_index - 1);
//
//     // Play current video
//     await _playController(_currIndex);
//
//     // // Cleanup old controllers
//     // if (_index - 3 >= 0) {
//     //   _removeController(_index - 3);
//     // }
//   }
//
//   Future<void> _initController(int index, bool isVertical) async {
//     var _posts = isVertical?_vPosts[_vNReply]:_hPosts[_hNReply];
//     if (_nestedRControllers.containsKey(_posts.elementAt(index).videoLink)) return;
//
//     var controller = VideoPlayerController.network(
//       _posts.elementAt(index).videoLink,
//       videoPlayerOptions: VideoPlayerOptions(
//         allowBackgroundPlayback: false,
//         mixWithOthers: false,
//       ),
//     );
//     _nestedRViewCountUpdated[_posts[index].id] = false;
//     _nestedRControllers[_posts.elementAt(index).videoLink] = controller;
//     controller.initialize().then((_) {
//       controller.setVolume(1.0);
//       // if (index == _currIndex) {
//       //   _playController(index);
//       // }
//     });
//   }
//
//   Future<void> _stopController(int index, bool isVertical) async {
//     // print("stop: $index :::: ${_controllers[posts.elementAt(index)[0].videoLink]} ::::::::::::::::::::::::::::::::::::::");
//     var posts= isVertical? _vPosts[_vNReply]:_hPosts[_hNReply];
//     var id = posts[index];
//
//     try {
//       if (index < 0 || index >= posts.length) return;
//
//       if (_nestedRListeners[id] != null) {
//         videoController(index,isVertical)?.removeListener(_nestedRListeners[id]!);
//       }
//       await videoController(index,isVertical)?.pause();
//       await videoController(index,isVertical)?.seekTo(const Duration(milliseconds: 0));
//     } catch (e) {
//       print("Error stopping controller at index $index: $e");
//     }
//   }
//
//   Future<void>  _playController(int index, bool isVertical) async {
//     // print("playing: $index :::: ${_controllers[posts.elementAt(index)[0].videoLink]} ::::::::::::::::::::::::::::::::::::::");
//     var _posts = isVertical? _vPosts[_vNReply]: _hPosts[_hNReply];
//
//     try {
//       if (index < 0 || index >= _posts.length) return;
//
//       if (!_nestedRListeners.keys.contains(_posts[index].id)) {
//         _nestedRListeners[index] = _listenerSpawner(index,isVertical);
//       }
//
//       final controller = videoController(index,isVertical);
//       if (controller != null) {
//         controller.removeListener(_nestedRListeners[_posts[index].id]!);
//         controller.addListener(_nestedRListeners[_posts[index].id]!);
//
//         if (_isPlaying) {
//           await controller.seekTo(const Duration(milliseconds: 0));
//           await controller.play();
//           await controller.setLooping(true);
//         } else {
//           await controller.pause();
//           await controller.setLooping(true);
//         }
//       }
//     } catch (e) {
//       print("Error playing controller at index $index: $e");
//     }
//   }
//
//
//
//
//   final Set<int> _fetchingIds = {};
//
//
//
//   Future<void> createReplyIsolate(int postId,int indexForFetch,bool isVertical,{String? token}) async {
//     var _posts = isVertical? _vPosts[_vNReply]: _hPosts[_hNReply] ;
//     if (!_canFetchReplies) {
//       print("Cannot fetch replies: waiting for posts to be loaded");
//       return;
//     }
//
//
//     if (_fetchingIds.contains(postId)) {
//       return;
//     }
//     _fetchingIds.add(postId);
//     _fetchingReplies = true;
//
//
//     ReceivePort mainReceivePort = ReceivePort();
//
//     try {
//       await Isolate.spawn(getRepliesTask, mainReceivePort.sendPort);
//
//       SendPort isolateSendPort = await mainReceivePort.first as SendPort;
//       ReceivePort isolateResponseReceivePort = ReceivePort();
//
//       isolateSendPort.send([
//         _posts[indexForFetch].id,
//         isolateResponseReceivePort.sendPort,
//         token
//       ]);
//
//       final isolateResponse = await isolateResponseReceivePort.first as List<Posts>;
//
//       // Clear existing replies before adding new ones
//       // if (_posts.length > 1) {
//       //
//       //   _posts[indexForFetch] = [_posts[indexForFetch]];
//       // }
//
//       if(isVertical){
//         _vNReply+=1;
//         _vPosts.add(isolateResponse);
//       }else{
//         _hNReply+=1;
//         _hPosts.add(isolateResponse);
//       }
//
//       isolateResponseReceivePort.close();
//       notifyListeners();
//
//     } catch (e) {
//       print("Error in createReplyIsolate: $e");
//     } finally {
//       _fetchingIds.remove(postId);
//       _fetchingReplies = false;
//       mainReceivePort.close();
//     }
//
//   }
//
//
//   static void getRepliesTask(SendPort mySendPort) async {
//     final _homeService = HomeService();
//     ReceivePort isolateReceivePort = ReceivePort();
//
//     mySendPort.send(isolateReceivePort.sendPort);
//
//     await for (var message in isolateReceivePort) {
//       if (message is List && message.length >= 2) {
//         final int postId = message[0];
//         final SendPort isolateResponseSendPort = message[1];
//         final String? token = message.length > 2 ? message[2] : null;
//
//         try {
//           final response = await _homeService.getReplies(postId, token ?? '');
//           final List<Posts> data = ReplyModel.fromJson(response).post;
//           isolateResponseSendPort.send(data);
//         } catch (e) {
//           print("Error in isolate: $e");
//           isolateResponseSendPort.send([]);
//         }
//       }
//     }
//   }
//
//
// }




class NestedRProvider with ChangeNotifier{

  final _homeService = HomeService();

  int _initialIndex=-1;

  get initialIndex=>_initialIndex;

  set initialIndex(val){
    _initialIndex=val;
    notifyListeners();
  }

  PageController _pageController=PageController();
  PageController get pageController=>_pageController;


  // Main controller maps for different context types
  final Map<String, VideoPlayerController> _nestedRControllers = {}; // For nested replies
  final Map<int, VoidCallback> _nestedRListeners = {}; // Keyed by postId
  final Map<int, bool> _nestedRViewCountUpdated = {};  // Keyed by postId

// Tracking current position in navigation hierarchy
  int _hNReply = -1; // Current horizontal reply level
  int _vNReply = -1; // Current vertical reply level
  bool _vScrollReply = true; // Direction flag (true=vertical, false=horizontal)

  int _currIndex = 0; // Current index within current level
  List<int> _currIndexTrack = []; // Stack to track indices when navigating
  int _vertical_drag_direction = 0; // -1 up, 1 down, 0 initial

// Content storage
  List<List<Posts>> _hPosts = []; // Posts for horizontal scrolling
  List<List<Posts>> _vPosts = []; // Posts for vertical scrolling

// State flags
  bool _isPlaying = false;
  bool _fetchingReplies = false;
  bool _canFetchReplies = true;
  bool _onReply = false; // Whether we're viewing replies

  bool get onReply=>_onReply;
  bool get isPlaying => _isPlaying;
  int get currIndex => _currIndex;

  set onReply(bool val){
    if(_onReply!=val){
      _onReply=val;
      notifyListeners();
    }
  }

  List<Posts> get getPost {
    print('${_vPosts} +++++++++++++++++${_hPosts}');
    if (_vScrollReply) {
      return (_vNReply >= 0 && _vNReply < _vPosts.length) ? _vPosts[_vNReply] : [];
    } else {
      return (_hNReply >= 0 && _hNReply < _hPosts.length) ? _hPosts[_hNReply] : [];
    }
  }





  void goToPreviousPage(){
    if(_currIndex-1<0) return;
    _currIndex-=1;
    _pageController.animateToPage(_currIndex, duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  void goToNextPage(){
    var val =(_vScrollReply?_vPosts[_vNReply].length:_hPosts[_hNReply].length);
    if(_currIndex<val);
    _currIndex+=1;
    _pageController.animateToPage(_currIndex, duration: Duration(milliseconds: 400), curve: Curves.linear);

  }



// Initialize video player with preloading for both directions
  Future<void> initializeRVideoPlayer(bool isVertical) async {
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];
    _currIndex = 0;
    _currIndexTrack.add(_currIndex);

    if (_posts.isEmpty) return;

    // Initialize current video and preload adjacent ones
    _isPlaying = true;
    await _initController(0, isVertical);

    // Preload next/previous in same direction
    if (_posts.length > 1) {
      await _initController(1, isVertical);
    }
    if (_posts.length > 2) {
      await _initController(2, isVertical);
    }

    // Preload one video in the perpendicular direction if available
    // This handles the case where user might switch scroll direction
    await _preloadPerpendicularVideo(isVertical);

    notifyListeners();
  }

// Preload one video in the perpendicular direction
  Future<void> _preloadPerpendicularVideo(bool currentDirection) async {
    // If we're in vertical scroll, preload one horizontal video and vice versa
    if (currentDirection) { // Currently vertical
      if (_hPosts.isNotEmpty && _hPosts[0].isNotEmpty) {
        var controller = VideoPlayerController.network(
          _hPosts[0][0].videoLink,
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false,
            mixWithOthers: false,
          ),
        );

        _nestedRControllers[_hPosts[0][0].videoLink] = controller;
        await controller.initialize();
      }
    } else { // Currently horizontal
      if (_vPosts.isNotEmpty && _vPosts[0].isNotEmpty) {
        var controller = VideoPlayerController.network(
          _vPosts[0][0].videoLink,
          videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: false,
            mixWithOthers: false,
          ),
        );

        _nestedRControllers[_vPosts[0][0].videoLink] = controller;
        await controller.initialize();
      }
    }
  }

// Get video controller for specific index and direction
  VideoPlayerController? videoController(int index, bool isVertical) {
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];
    if (_posts.isEmpty || index < 0 || index >= _posts.length) {
      return null;
    }
    return _nestedRControllers[_posts.elementAt(index).videoLink];
  }

// Create a listener for video events
  VoidCallback _listenerSpawner(int index, bool isVertical) {
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];
    return () {
      final controller = videoController(index, isVertical);

      if (controller?.value.hasError == true) {
        print(controller?.value.errorDescription ?? '');
        return;
      }

      if (controller?.value.isInitialized == true) {
        final position = controller?.value.position;
        final duration = controller?.value.duration;

        if (position != null && duration != null) {
          final positionMs = position.inMilliseconds;
          final durationMs = duration.inMilliseconds;
          final positionDifference = durationMs - positionMs;

          if (durationMs < 1) return;

          // Update view count if needed
          int postId = _posts.elementAt(index).id;
          if (positionMs > 1000 && !_nestedRViewCountUpdated[postId]! && logged_in!) {
            updateViewCount(id: postId);
            _nestedRViewCountUpdated[postId] = true;
          }

          // Handle video completion
          if (positionDifference <= 400) {
            _nestedRViewCountUpdated[postId] = false;
            // Implement any auto-scroll logic here if needed
          }
        }
      }

      notifyListeners();
    };
  }

  Future<void> updateViewCount({required int id}) async {
    Map data = {
      "post_id": id,
    };
    await _homeService.view(data: data);
    notifyListeners();
  }

// Smart cleanup of controllers to prevent memory leaks
  void _cleanupControllers(int currentIndex) {
    var _posts = _vScrollReply ? _vPosts[_vNReply] : _hPosts[_hNReply];
    final keepRange = 2; // Range of controllers to keep on each side
    final validIndices = <int>{};

    // Calculate valid indices to keep in current direction
    for (var i = currentIndex - keepRange; i <= currentIndex + keepRange; i++) {
      if (i >= 0 && i < _posts.length) {
        validIndices.add(i);
      }
    }

    // Get URLs that should be kept (including perpendicular direction)
    final keepUrls = <String>{};

    // Keep videos in current direction
    for (var idx in validIndices) {
      if (idx < _posts.length) {
        keepUrls.add(_posts.elementAt(idx).videoLink);
      }
    }

    // Always keep one video from perpendicular direction if available
    if (_vScrollReply && _hPosts.isNotEmpty && _hPosts[0].isNotEmpty) {
      keepUrls.add(_hPosts[0][0].videoLink);
    } else if (!_vScrollReply && _vPosts.isNotEmpty && _vPosts[0].isNotEmpty) {
      keepUrls.add(_vPosts[0][0].videoLink);
    }

    // Clean up controllers that aren't needed
    final linksToRemove = <String>[];
    _nestedRControllers.forEach((videoLink, controller) {
      if (!keepUrls.contains(videoLink)) {
        controller.pause();
        controller.dispose();
        linksToRemove.add(videoLink);
      }
    });

    // Remove disposed controllers from the map
    for (var link in linksToRemove) {
      _nestedRControllers.remove(link);
    }

    // Clean up listeners for removed videos
    _nestedRListeners.removeWhere((postId, _) {
      bool shouldRemove = true;

      // Check if this postId still has a video that needs a listener
      for (var direction in [true, false]) {
        var posts = direction ? _vPosts : _hPosts;
        var level = direction ? _vNReply : _hNReply;

        if (level < posts.length) {
          for (var post in posts[level]) {
            if (post.id == postId && _nestedRControllers.containsKey(post.videoLink)) {
              shouldRemove = false;
              break;
            }
          }
        }

        if (!shouldRemove) break;
      }

      return shouldRemove;
    });
  }

// Handle page changing with direction awareness
  Future<void> onPageChanged(int index, bool isVertical) async {
    _isPlaying = true;
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];

    // Store old index before updating
    final oldIndex = _currIndex;

    // Update current index
    _currIndex = index;

    // Initialize current video if not already loaded
    if (!_nestedRControllers.containsKey(_posts.elementAt(index).videoLink)) {
      await _initController(index, isVertical);
    }

    // Stop the previous video
    await _stopController(oldIndex, isVertical);

    // Play the current video and preload based on scroll direction
    if (_vertical_drag_direction == -1) {
      // User is scrolling up
      await _playController(index, isVertical);

      // Preload previous videos
      if (index - 1 >= 0) await _initController(index - 1, isVertical);
      if (index - 2 >= 0) await _initController(index - 2, isVertical);
    } else if (_vertical_drag_direction == 1) {
      // User is scrolling down
      await _playController(index, isVertical);

      // Preload next videos
      if (index + 1 < _posts.length) await _initController(index + 1, isVertical);
      if (index + 2 < _posts.length) await _initController(index + 2, isVertical);
    } else {
      // Initial load or horizontal swipe
      await _playController(index, isVertical);

      // Preload adjacent videos
      if (index + 1 < _posts.length) await _initController(index + 1, isVertical);
      if (index - 1 >= 0) await _initController(index - 1, isVertical);
    }

    // Also preload one video in perpendicular direction
    await _preloadPerpendicularVideo(isVertical);

    // Clean up controllers that aren't needed
    _cleanupControllers(index);

    notifyListeners();
  }

// Initialize a controller for a specific index
  Future<void> _initController(int index, bool isVertical) async {
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];

    if (index < 0 || index >= _posts.length) return;

    String videoLink = _posts.elementAt(index).videoLink;
    if (_nestedRControllers.containsKey(videoLink)) return;

    var controller = VideoPlayerController.network(
      videoLink,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );

    _nestedRViewCountUpdated[_posts[index].id] = false;
    _nestedRControllers[videoLink] = controller;

    try {
      await controller.initialize();
      controller.setVolume(1.0);

      if (index == _currIndex && isVertical == _vScrollReply && _isPlaying) {
        await _playController(index, isVertical);
      }
    } catch (e) {
      print("Error initializing video at index $index: $e");
    }
  }

// Stop a video controller
  Future<void> _stopController(int index, bool isVertical) async {
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];

    if (index < 0 || index >= _posts.length) return;

    int postId = _posts[index].id;
    final controller = videoController(index, isVertical);

    try {
      if (_nestedRListeners.containsKey(postId)) {
        controller?.removeListener(_nestedRListeners[postId]!);
      }

      await controller?.pause();
      await controller?.seekTo(const Duration(milliseconds: 0));
    } catch (e) {
      print("Error stopping controller at index $index: $e");
    }
  }

// Play a video controller
  Future<void> _playController(int index, bool isVertical) async {
    var _posts = isVertical ? _vPosts[_vNReply] : _hPosts[_hNReply];

    if (index < 0 || index >= _posts.length) return;

    int postId = _posts[index].id;
    final controller = videoController(index, isVertical);

    try {
      if (controller == null || !controller.value.isInitialized) {
        await _initController(index, isVertical);
        return;
      }

      // Create listener if it doesn't exist
      if (!_nestedRListeners.containsKey(postId)) {
        _nestedRListeners[postId] = _listenerSpawner(index, isVertical);
      }

      // Update the listener
      controller.removeListener(_nestedRListeners[postId]!);
      controller.addListener(_nestedRListeners[postId]!);

      if (_isPlaying) {
        await controller.seekTo(const Duration(milliseconds: 0));
        await controller.play();
        await controller.setLooping(true);
      } else {
        await controller.pause();
        await controller.setLooping(true);
      }
    } catch (e) {
      print("Error playing controller at index $index: $e");
    }
  }

// Navigate to nested replies
  Future<void> navigateToNestedReplies(int postId, bool goVertical) async {
    if (_fetchingReplies) return;

    // Update the reply state
    _onReply = true;
    _vScrollReply = goVertical;

    // Fetch replies and update the appropriate level
    await createReplyIsolate(postId, goVertical, token: token);

    // Initialize videos for the new level
    await initializeRVideoPlayer(goVertical);
  }

// Navigate back to previous level
  void navigateBack() {
    if (_currIndexTrack.isEmpty) return;

    if (_vScrollReply && _vNReply > 0) {
      // Stop current videos
      var _posts = _vPosts[_vNReply];
      for (int i = 0; i < _posts.length; i++) {
        _stopController(i, true);
      }

      _vNReply--;
      _currIndex = _currIndexTrack.removeLast();

      // Reset _onReply flag if we've gone back to the main feed
      _onReply = _vNReply > 0 || _hNReply > 0;

      initializeRVideoPlayer(true);
    } else if (!_vScrollReply && _hNReply > 0) {
      // Stop current videos
      var _posts = _hPosts[_hNReply];
      for (int i = 0; i < _posts.length; i++) {
        _stopController(i, false);
      }

      _hNReply--;
      _currIndex = _currIndexTrack.removeLast();

      // Reset _onReply flag if we've gone back to the main feed
      _onReply = _hNReply > 0 || _vNReply > 0;

      initializeRVideoPlayer(false);
    }
  }

// Dispose all controllers
  Future<void> disposeAllControllers() async {
    for (var controller in _nestedRControllers.values) {
      await controller.pause();
      await controller.dispose();
    }

    _nestedRControllers.clear();
    _nestedRListeners.clear();
    _nestedRViewCountUpdated.clear();
  }

// Track which IDs we're currently fetching to prevent duplicates
  final Set<int> _fetchingIds = {};

// Fetch replies using isolate for performance
  Future<void> createReplyIsolate(int postId, bool isVertical, {String? token}) async {
    if (!_canFetchReplies || _fetchingIds.contains(postId)) return;

    bool isAlreadyThere = _vPosts.any((sublist) => sublist.any((post) => post.id == postId));

    if(isAlreadyThere) return;

    _fetchingIds.add(postId);
    _fetchingReplies = true;
    notifyListeners();

    ReceivePort mainReceivePort = ReceivePort();

    try {
      await Isolate.spawn(getRepliesTask, mainReceivePort.sendPort);

      SendPort isolateSendPort = await mainReceivePort.first as SendPort;
      ReceivePort isolateResponseReceivePort = ReceivePort();

      isolateSendPort.send([
        postId,
        isolateResponseReceivePort.sendPort,
        token
      ]);

      final isolateResponse = await isolateResponseReceivePort.first as List<Posts>;

      // Store replies in the appropriate list
      if(isolateResponse.isNotEmpty){
        if (isVertical) {
          _vNReply++;
          _vPosts.add(isolateResponse);

        } else {
          _hNReply++;
          _hPosts.add(isolateResponse);

        }
      }

      isolateResponseReceivePort.close();

    } catch (e) {
      print("Error in createReplyIsolate: $e");
    } finally {
      _fetchingIds.remove(postId);
      _fetchingReplies = false;
      mainReceivePort.close();
      notifyListeners();
    }
  }

// Static method for isolate to fetch replies
  static void getRepliesTask(SendPort mySendPort) async {
    final _homeService = HomeService();
    ReceivePort isolateReceivePort = ReceivePort();

    mySendPort.send(isolateReceivePort.sendPort);

    await for (var message in isolateReceivePort) {
      if (message is List && message.length >= 2) {
        final int postId = message[0];
        final SendPort isolateResponseSendPort = message[1];
        final String? token = message.length > 2 ? message[2] : null;

        try {
          final response = await _homeService.getReplies(postId, token ?? '');
          final List<Posts> data = ReplyModel.fromJson(response).post;
          isolateResponseSendPort.send(data);
        } catch (e) {
          print("Error in isolate: $e");
          isolateResponseSendPort.send([]);
        }
      }
    }
  }


}