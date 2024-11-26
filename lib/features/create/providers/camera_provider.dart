import 'dart:developer';
import 'package:socialverse/export.dart';

class CameraProvider extends ChangeNotifier {
  late CameraController cameraController;
  VideoPlayerController? videoController;

  XFile? selectedVideo;

  late bool _isCameraReady;

  bool _isTimerRunning = false;

  String _recordingDuration = "00:00";
  String get recordingDuration => _recordingDuration;

  Timer? _recordingTimer;

  int _recordingSeconds = 0;
  bool _isDisposed = false;

  List<AssetEntity> _assets = <AssetEntity>[];
  List<AssetEntity> get assets => _assets;

  double _recordPercentage = 0.0;
  double get recordPercentage => _recordPercentage;

  set recordPercentage(double value) {
    _recordPercentage = value;
    notifyListeners();
  }

  bool _isCameraFlashOn = false;
  bool get isCameraFlashOn => _isCameraFlashOn;

  set isCameraFlashOn(bool value) {
    _isCameraFlashOn = value;
    notifyListeners();
  }

  bool _isVideoRecord = false;
  bool get isVideoRecord => _isVideoRecord;

  set isVideoRecord(bool value) {
    _isVideoRecord = value;
    notifyListeners();
  }

  bool _isRecordStart = true;
  bool get isRecordStart => _isRecordStart;

  set isRecordStart(bool value) {
    _isRecordStart = value;
    notifyListeners();
  }

  double _percentIndicatorRadius = 70.0;
  double get percentIndicatorRadius => _percentIndicatorRadius;

  set percentIndicatorRadius(double value) {
    _percentIndicatorRadius = value;
    notifyListeners();
  }

  double _buttonPressSize = 50.0;
  double get buttonPressSize => _buttonPressSize;

  set buttonPressSize(double value) {
    _buttonPressSize = value;
    notifyListeners();
  }

  bool shouldStartRecording = false;

  bool _isCameraFlip = false;
  bool get isCameraFlip => _isCameraFlip;

  set isCameraFlip(bool value) {
    _isCameraFlip = value;
    notifyListeners();
  }

  bool _isVideoPause = false;
  bool get isVideoPause => _isVideoPause;

  set isVideoPause(bool value) {
    _isVideoPause = value;
    notifyListeners();
  }

  bool _showCameraScreen = false;
  bool get showCameraScreen => _showCameraScreen;

  set showCameraScreen(bool value) {
    _showCameraScreen = value;
    notifyListeners();
  }

  double _videoSpeed = 1.0;
  double get videoSpeed => _videoSpeed;

  set videoSpeed(double value) {
    _videoSpeed = value;
    notifyListeners();
  }

  Future<void> initCamera(
      {required CameraDescription value, required bool mounted}) async {
    cameraController = CameraController(
      value,
      ResolutionPreset.max,
      enableAudio: true, // Make sure audio is enabled if needed
    );

    try {
      await cameraController.initialize().then((_) {
        _isCameraReady = true;
        if (!mounted) return;
        notifyListeners();
      });

      // Make sure flash is initially off
      await cameraController.setFlashMode(FlashMode.off);
      _isCameraFlashOn = false;

      // Start recording if flag is set
      if (shouldStartRecording) {
        await startRecording();
        shouldStartRecording = false;
      }
    } on CameraException catch (e) {
      debugPrint("camera error $e");
      _isCameraReady = false;
      notifyListeners();
    }
  }

  Future<void> startRecording() async {
    buttonPressSize = 70;
    percentIndicatorRadius = 50;
    isRecordStart = true;
    isVideoRecord = true;

    if (isCameraFlashOn) {
      await cameraController.setFlashMode(FlashMode.torch);
    }

    await cameraController.startVideoRecording();
    log('DEBUG: Recording started');
    startRecordingTimer();
    startProgress();
  }

  Future<void> stopRecording() async {
    progressReset();

    if (isCameraFlashOn) {
      await cameraController.setFlashMode(FlashMode.off);
    }

    stopRecordingTimer();
    selectedVideo = await cameraController.stopVideoRecording();
    initVideo();
    cameraController.buildPreview();
    log('DEBUG: Recording stopped');
  }

  void startProgress() {
    recordPercentage = 0.0;
    _isTimerRunning = true;

    Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      recordPercentage += 0.001667;
      if (recordPercentage >= 1.0) {
        recordPercentage = 1.0;
        _isTimerRunning = false;
        timer.cancel();
        if (isVideoRecord) {
          await stopRecording();
        }
      }
      notifyListeners();
    });
  }

  void stopProgress() {
    if (_isTimerRunning) {
      _isTimerRunning = false;
    }
    recordPercentage = 0.0;
    notifyListeners();
  }

  void progressReset() {
    recordPercentage = 0.0;
    percentIndicatorRadius = 40;
    buttonPressSize = 50;
    isRecordStart = false;
    isVideoRecord = false;
    notifyListeners();
  }

  Future<void> handleFirstClick() async {
    // Simplified to only start recording
    percentIndicatorRadius = 50;
    isRecordStart = true;
    isVideoRecord = true;

    await startRecording();
    log('DEBUG: Recording started');
  }

  void initVideo() {
    if (selectedVideo != null) {
      videoController = VideoPlayerController.file(File(selectedVideo!.path));
      videoController!.addListener(() {
        notifyListeners();
      });
      videoController?.setLooping(true);
      videoController?.initialize().then((_) {
        videoController?.setPlaybackSpeed(videoSpeed);
        videoController?.play();
        notifyListeners();
      });
    }
  }

  void startRecordingTimer() {
    _recordingSeconds = 0;
    _recordingDuration = "00:00";

    _recordingTimer?.cancel();

    if (!_isDisposed) {
      _recordingTimer = Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          if (_isDisposed) {
            timer.cancel();
            return;
          }

          _recordingSeconds++;

          // Format minutes and seconds
          final minutes = (_recordingSeconds ~/ 60).toString().padLeft(2, '0');
          final seconds = (_recordingSeconds % 60).toString().padLeft(2, '0');

          _recordingDuration = "$minutes:$seconds";
          notifyListeners();
        },
      );
    }
  }

  void stopRecordingTimer() {
    if (!_isDisposed) {
      _recordingTimer?.cancel();
      _recordingTimer = null;
      _recordingSeconds = 0;
      _recordingDuration = "00:00";
      notifyListeners();
    }
  }

  void flipCamera({required List<CameraDescription> cameras}) {
    if (_isCameraReady) {
      final lensDirection = cameraController.description.lensDirection;
      final newCamera = cameras.firstWhere(
        (camera) => camera.lensDirection != lensDirection,
      );
      cameraController = CameraController(
        newCamera,
        ResolutionPreset.high,
      );
      cameraController.initialize().then((_) {
        notifyListeners();
      });
    }
  }
  
  void resetValues() {
  if (_isDisposed) return;
  if (videoController != null) {
    videoController!.pause();
    videoController!.dispose();
    videoController = null; 
  }
  selectedVideo = null;
  _recordingSeconds = 0;
  _recordingDuration = "00:00";
  _videoSpeed = 1.0;
  _isCameraFlip = false;
  _isVideoPause = false;
  _isRecordStart = true;
  _isVideoRecord = false;
  _buttonPressSize = 50.0;
  _percentIndicatorRadius = 70.0;
  _showCameraScreen = false;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!_isDisposed) notifyListeners();
  });
}


  // void resetValues() {
  //   if (_isDisposed) return;
  //   if (videoController != null) {
  //     videoController!.pause();
  //     videoController!.dispose();
  //   }
  //   selectedVideo = null;
  //   videoController = null;
  //   _recordingSeconds = 0;
  //   _recordingDuration = "00:00";
  //   _videoSpeed = 1.0;
  //   _isCameraFlip = false;
  //   _isVideoPause = false;
  //   _isRecordStart = true;
  //   _isVideoRecord = false;
  //   _buttonPressSize = 50.0;
  //   _percentIndicatorRadius = 70.0;
  //   _showCameraScreen = false;
  //   notifyListeners();
  // }

  Future<void> toggleFlash() async {
    if (_isCameraReady) {
      try {
        isCameraFlashOn = !isCameraFlashOn;

        if (isCameraFlashOn) {
          await cameraController.setFlashMode(FlashMode.torch);
          print("Flash ON"); // Debug print
        } else {
          await cameraController.setFlashMode(FlashMode.off);
          print("Flash OFF"); // Debug print
        }
      } catch (e) {
        print('Flash error: $e');
        // Reset flash state if there's an error
        isCameraFlashOn = false;
      }
    } else {
      print('Camera not ready'); // Debug print
    }
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _isDisposed = true;
    videoController?.dispose();
    cameraController.dispose();
    super.dispose();
  }

  Future<void> imagePicker(BuildContext context) async {
    await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: RequestType.video,
        maxAssets: 1,
        selectedAssets: _assets,
      ),
    ).then((value) async {
      if (value != null && value.isNotEmpty) {
        await value[0].originFile.then((file) {
          if (file != null) {
            selectedVideo = XFile(file.path);
            initVideo();
            cameraController.buildPreview();
            notifyListeners();
          }
        });
      }
    });
  }
}
