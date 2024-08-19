import 'package:socialverse/export.dart';

class ExitProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer = AudioPlayer();

  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;

  bool _isInit = false;
  bool get isInit => _isInit;

  Timer? _hapticTimer;

  set isInit(bool value) {
    _isInit = value;
    notifyListeners();
  }

  initPlayer() async {
    _controller = await VideoPlayerController.asset(AppAsset.exit);
    await controller!.initialize();
    if (Platform.isIOS) {
      _playAudio();
    }
    controller?.addListener(videoEndListener);
    isInit = true;
    startHapticFeedbackLoop();
    notifyListeners();
  }

  void _playAudio() {
    _audioPlayer.play(AssetSource(AppAsset.daylight));
  }

  void videoEndListener() {
    if (controller!.value.position == controller!.value.duration) {
      stopHapticFeedbackLoop();
      performExit();
    }
  }

  void startHapticFeedbackLoop() {
    _hapticTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      HapticFeedback.vibrate();
    });
  }

  void stopHapticFeedbackLoop() {
    _hapticTimer?.cancel();
  }

  void performExit() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _hapticTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
