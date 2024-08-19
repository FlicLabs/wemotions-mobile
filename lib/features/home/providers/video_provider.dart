import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

class VideoProvider extends ChangeNotifier {
  final videPageController = PageController();
  final _service = HomeService();

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  int _index = 0;
  int get index => _index;

  set index(int value) {
    _index = value;
  }

  bool _isPlaying = true;
  bool get isPlaying => _isPlaying;

  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  set isFollowing(bool value) {
    _isFollowing = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;

  List<dynamic> _posts = <dynamic>[];
  List<dynamic> get posts => _posts;

  set posts(List<dynamic> value) {
    _posts = value;
  }

  bool _isViewMode = false;
  bool get isViewMode => _isViewMode;

  set isViewMode(bool value) {
    _isViewMode = value;
    notifyListeners();
  }

  bool _downloading = false;
  bool get downloading => _downloading;

  bool _downloadingCompleted = false;
  bool get downloadingCompleted => _downloadingCompleted;

  dynamic _progressString = '';
  dynamic get progressString => _progressString;

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

  Future<void> updateViewCount({required int id}) async {
    Map data = {
      "post_id": id,
    };
    await _service.view(data: data);
    notifyListeners();
  }

  Future<void> updateExitCount({required int id}) async {
    Map data = {
      "post_id": id,
    };
    await _service.inspire(data: data);
    notifyListeners();
  }

  Future<void> saveDownloadedVideoToGallery({required String videoPath}) async {
    await ImageGallerySaver.saveFile(videoPath);
    log("Video Saved to Gallery");
  }

  Future<void> removeDownloadedVideo({required String videoPath}) async {
    try {
      Directory(videoPath).deleteSync(recursive: true);
      log("Video Deleted from App Directory");
    } catch (error) {
      debugPrint('$error');
      log(error.toString());
    }
  }

  Future<void> saveVideo({
    required String videoUrl,
    required String title,
  }) async {
    Dio dio = Dio();
    try {
      var dir;
      if (Platform.isAndroid) {
        dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
      // _dirPath = dir;
      log("path ${Platform.isIOS ? dir : dir.path}");

      final String videoPath = join(
        dir.path,
        '$title.mp4',
      );

      await dio.download(
        videoUrl,
        videoPath,
        onReceiveProgress: (rec, total) {
          // debugPrint("Rec: $rec , Total: $total");
          _downloading = true;
          _progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          notifyListeners();
        },
      );

      await saveDownloadedVideoToGallery(videoPath: videoPath);
      await removeDownloadedVideo(videoPath: videoPath);
    } catch (e) {
      debugPrint(e.toString());
    }
    _downloading = false;
    _downloadingCompleted = true;
    _progressString = "Completed";
    notifyListeners();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        _downloadingCompleted = false;
        notifyListeners();
        // Share.shareXFiles([XFile(_dirPath.path)], text: 'Share Video');
      },
    );
    log("Download completed");
    notifyListeners();
  }

  Map<String, VideoPlayerController> videoControllers = {};
  Map<int, VoidCallback> videoListeners = {};
  Map<int, bool> _viewCountUpdated = {};

  initController(
    int index,
    dynamic postList,
  ) {
    videoControllers = {};
    videoListeners = {};
    _posts = postList;
    _isPlaying = true;
    if (postList.isNotEmpty) {
      _initController(index).then((_) {
        _playController(index);
      });
    }

    if (index == 0) {
      if (postList.length > 1) {
        _initController(1);
      }
    } else if (index == (postList.length - 1)) {
      _initController(index - 1);
    } else {
      _initController(index - 1);
      _initController(index + 1);
    }
  }

  VoidCallback _listenerSpawner(index) {
    return () {
      final controller = videoController(index);

      if (controller?.value.hasError == true) {
        print(controller?.value.errorDescription ?? '');
      }

      if (controller?.value.isInitialized == true) {
        final position = controller?.value.position;
        final duration = controller?.value.duration;

        if (position != null && duration != null) {
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
            _viewCountUpdated[index] = false;
          }
        }
      }
      notifyListeners();
    };
  }

  VideoPlayerController? videoController(int index) {
    return videoControllers[_posts.elementAt(index).videoLink];
  }

  Future<void> _initController(int index) async {
    var controller =
        VideoPlayerController.network(posts.elementAt(index).videoLink);
    videoControllers[posts.elementAt(index).videoLink] = controller;
    _viewCountUpdated[index] = false;
    await controller.initialize();
  }

  void _removeController(int index) {
    videoController(index)?.dispose();
    videoControllers.remove(_posts.elementAt(index));
    videoListeners.remove(index);
  }

  void _stopController(int index) {
    if (videoListeners[index] != null) {
      videoController(index)?.removeListener(videoListeners[index]!);
    }
    videoController(index)?.pause();
    videoController(index)?.seekTo(const Duration(milliseconds: 0));
  }

  void _playController(int index) async {
    if (!videoListeners.keys.contains(index)) {
      videoListeners[index] = _listenerSpawner(index);
    }
    notifyListeners();
    videoController(index)?.addListener(videoListeners[index]!);
    // log("video initiated in video widget");
    if (_isPlaying) {
      await videoController(index)?.play();
      // log("video played in video widget");
      await videoController(index)?.setLooping(true);
    }
  }

  void previousVideo() {
    if (_index == 0) {
      return;
    }
    _stopController(_index);
    notifyListeners();

    if (_index + 1 < _posts.length) {
      _removeController(_index + 1);
    }

    _playController(--_index);
    notifyListeners();

    if (_index == 0) {
    } else {
      _initController(_index - 1);
    }
    notifyListeners();
  }

  void nextVideo() async {
    if (_index == posts.length - 1) {
      return;
    }
    _stopController(_index);
    notifyListeners();

    if (_index - 1 >= 0) {
      _removeController(_index - 1);
    }

    _playController(++_index);
    notifyListeners();
    if (_index == posts.length - 1) {
    } else {
      _initController(_index + 1);
    }
    notifyListeners();
  }
}
