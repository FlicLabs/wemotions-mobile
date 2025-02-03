import 'dart:developer';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:socialverse/export.dart';

class CameraProvider extends ChangeNotifier {
  late CameraController cameraController;
  VideoPlayerController? videoController;

  XFile? selectedVideo;

  bool _isCameraReady = false;
  bool get isCameraReady => _isCameraReady;

  String _recordingDuration = "00:00";
  String get recordingDuration => _recordingDuration;

  Timer? _recordingTimer;

  int _recordingSeconds = 0;

  // Start recording timer
  void startRecordingTimer() {
    _recordingSeconds = 0;
    _recordingDuration = "00:00";

    _recordingTimer?.cancel();

    _recordingTimer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        _recordingSeconds++;

        // Format minutes and seconds
        final minutes = (_recordingSeconds ~/ 60).toString().padLeft(2, '0');
        final seconds = (_recordingSeconds % 60).toString().padLeft(2, '0');

        _recordingDuration = "$minutes:$seconds";
        notifyListeners();
      },
    );
  }

  // Stop recording timer
  void stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _recordingSeconds = 0;
    _recordingDuration = "00:00";
    notifyListeners();
  }

  bool _isDisposed = false;

  bool _recordingCompleted=false;
  bool get recordingCompleted=>_recordingCompleted;

  set recordingCompleted(bool val){
    _recordingCompleted=val;
    notifyListeners();
  }


  bool _hasPermission=false;
  bool get hasPermission=>_hasPermission;

  set hasPermission(bool val){
    _hasPermission=val;
    notifyListeners();
  }

  // bool _isDraggedLeft = false;
  // bool get isDraggedLeft=>_isDraggedLeft;
  //
  // set isDraggedLeft(bool val){
  //   _isDraggedLeft=val;
  //   notifyListeners();
  // }
  //
  // double _dragStartX = 0.0;
  // double get dragStartX => _dragStartX;
  //
  // set dragStartX(double val){
  //   _dragStartX=val;
  //   notifyListeners();
  // }

  Offset? _pressPosition;

  Offset? get pressPosition=>_pressPosition;

  set pressPosition(Offset? val){
    _pressPosition=val;
    notifyListeners();
  }

  bool _isRecordingLocked = false;
  bool get isRecordingLocked=>_isRecordingLocked;

  set isRecordingLocked(bool val){
    _isRecordingLocked=val;
    notifyListeners();
  }

  void toggleRecordingLock() {
    _isRecordingLocked = !_isRecordingLocked;
    notifyListeners();
  }

  bool _isLockIconHovered=false;
  bool get isLockIconHovered => _isLockIconHovered;

  set isLockIconHovered(bool val){
    _isLockIconHovered=val;
    notifyListeners();
  }


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


  bool _isLongPressed = false;
  bool get isLongPressed => _isLongPressed;

  set isLongPressed(bool value) {
    _isLongPressed = value;
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

  bool _isTimerOn = false;
  bool get isTimerOn => _isTimerOn;

  set isTimerOn(bool value) {
    _isTimerOn = value;
    notifyListeners();
  }

  int _timerValue = 0;
  int get timerValue => _timerValue;

  int _selectedTimerDuration = 0;
  int get selectedTimerDuration => _selectedTimerDuration;

  set selectedTimerDuration(int value) {
    _selectedTimerDuration = value;
    notifyListeners();
  }

  // ======================== Zoom Variables =========================
  double _currentZoomLevel = 1.0;
  double get currentZoomLevel => _currentZoomLevel;
  set currentZoomLevel(double val){
    _currentZoomLevel=val;
  }

  double _minZoomLevel = 1.0;
  double get minZoomLevel => _minZoomLevel;

  double _maxZoomLevel = 1.0;
  double get maxZoomLevel => _maxZoomLevel;

  Timer? _zoomDebounceTimer; // Debounce Timer for Zoom
  // ======================================================================

  // ======================== Video Segments ==========================
  List<XFile> _videoSegments = [];
  List<XFile> get videoSegments => _videoSegments;
  // ======================================================================

  // ======================== Permissions ==============================
  Future<void> requestPermissions() async {
    // Check each permission status
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      // Permission.storage,
    ].request();

    // Check if all permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    if (!allGranted) {
      // Optionally, you can show a dialog directing users to app settings
      // or handle the denial gracefully.
      throw Exception('Permissions not granted');
    }
  }
  // ======================================================================

  /// Initialize the camera with the given [CameraDescription]
  Future<void> initCamera({
    required CameraDescription description,
    required bool mounted,
  }) async {
    try {
      await requestPermissions(); // Ensure permissions are granted

      cameraController = CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: true, // Ensure audio is enabled if needed
        imageFormatGroup:
            ImageFormatGroup.jpeg, // Optional: specify image format
      );

      await cameraController.initialize();
      _isCameraReady = true;
      notifyListeners();

      // Ensure flash is initially off
      await cameraController.setFlashMode(FlashMode.off);
      _isCameraFlashOn = false;

      // Fetch min and max zoom levels
      _minZoomLevel = await cameraController.getMinZoomLevel();
      _maxZoomLevel = await cameraController.getMaxZoomLevel();

      // Initialize current zoom level
      _currentZoomLevel = _minZoomLevel;
      await cameraController.setZoomLevel(_currentZoomLevel);
      notifyListeners();

      // Start recording if the flag is set
      if (shouldStartRecording) {
        await startRecording();
        shouldStartRecording = false;
      }
    } on CameraException catch (e) {
      debugPrint("Camera error: $e");
      _isCameraReady = false;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint("Permission error: $e");
      _isCameraReady = false;
      notifyListeners();
      // Optionally, you can rethrow or handle the exception as needed
    }
  }

  // ======================== Zoom Method ============================
  /// Sets the zoom level with debouncing to ensure smooth transitions
  Future<void> setZoomLevel(double zoom) async {
    if (!_isCameraReady) return;

    // Clamp zoom level between min and max
    double newZoom = zoom.clamp(_minZoomLevel, _maxZoomLevel);

    // Cancel any existing debounce timer
    _zoomDebounceTimer?.cancel();

    // Start a new debounce timer
    _zoomDebounceTimer = Timer(const Duration(milliseconds: 50), () async {
      try {
        await cameraController.setZoomLevel(newZoom);
        _currentZoomLevel = newZoom;
        notifyListeners();
      } catch (e) {
        log('Error setting zoom level: $e');
      }
    });
  }
  // ======================================================================

  /// Starts video recording
  Future<void> startRecording() async {
    _buttonPressSize = 70;
    _percentIndicatorRadius = 50;
    _isRecordStart = true;
    _isVideoRecord = true;

    if (_isCameraFlashOn) {
      await cameraController.setFlashMode(FlashMode.torch);
    }

    try {
      await cameraController.startVideoRecording();
      log('DEBUG: Recording started');
      startRecordingTimer();
      startProgress();
    } catch (e) {
      log('Error starting video recording: $e');
    }
  }

  /// Stops video recording
  Future<void> stopRecording() async {
    progressReset();

    if (_isCameraFlashOn) {
      await cameraController.setFlashMode(FlashMode.off);
    }

    stopRecordingTimer();
    try {
      selectedVideo = await cameraController.stopVideoRecording();
      _videoSegments.add(selectedVideo!); // Store the segment
      initVideo();
      cameraController.buildPreview();
      log('DEBUG: Recording stopped');
    } catch (e) {
      log('Error stopping video recording: $e');
    }
    _recordingCompleted=true;
  }

  /// Handles recording progress
  void startProgress() {
    _recordPercentage = 0.0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      _recordPercentage += 0.001667;
      if (_recordPercentage >= 1.0) {
        _recordPercentage = 1.0;
        timer.cancel();
        if (_isVideoRecord) {
          await stopRecording();
        }
      }
      notifyListeners();
    });
  }

  /// Stops recording progress
  void stopProgress() {
    _recordPercentage = 0.0;
    notifyListeners();
  }

  /// Resets progress indicators and flags
  void progressReset() {
    _recordPercentage = 0.0;
    _percentIndicatorRadius = 40;
    _buttonPressSize = 50;
    _isRecordStart = false;
    _isVideoRecord = false;
    notifyListeners();
  }


  /// Initializes the video player after recording
  void initVideo() {
    if (selectedVideo != null) {
      videoController = VideoPlayerController.file(File(selectedVideo!.path));
      videoController!.addListener(() {
        notifyListeners();
      });
      videoController?.setLooping(true);
      videoController?.initialize().then((_) {
        videoController?.setPlaybackSpeed(_videoSpeed);
        videoController?.play();
        notifyListeners();
      });
    }
  }

  /// Starts the recording timer
  // void startRecordingTimer() {
  //   _recordingSeconds = 0;
  //   _recordingDuration = "00:00";
  //
  //   _recordingTimer?.cancel();
  //
  //   if (!_isDisposed) {
  //     _recordingTimer = Timer.periodic(
  //       const Duration(seconds: 1),
  //       (Timer timer) {
  //         if (_isDisposed) {
  //           timer.cancel();
  //           return;
  //         }
  //
  //         _recordingSeconds++;
  //
  //         // Format minutes and seconds
  //         final minutes = (_recordingSeconds ~/ 60).toString().padLeft(2, '0');
  //         final seconds = (_recordingSeconds % 60).toString().padLeft(2, '0');
  //
  //         _recordingDuration = "$minutes:$seconds";
  //         notifyListeners();
  //       },
  //     );
  //   }
  // }

  // /// Stops the recording timer
  // void stopRecordingTimer() {
  //   if (!_isDisposed) {
  //     _recordingTimer?.cancel();
  //     _recordingTimer = null;
  //     _recordingSeconds = 0;
  //     _recordingDuration = "00:00";
  //     notifyListeners();
  //   }
  // }

  // ======================== Enhanced flipCamera ========================
  /// Flips the camera between front and back
  Future<void> flipCamera({required List<CameraDescription> cameras}) async {
    if (_isCameraReady) {
      final lensDirection = cameraController.description.lensDirection;
      CameraDescription newCamera;

      try {
        newCamera = cameras.firstWhere(
          (camera) => camera.lensDirection != lensDirection,
        );
      } catch (e) {
        log('No alternative camera found.');
        return;
      }

      bool wasRecording = _isVideoRecord;

      if (wasRecording) {
        await stopRecording();
      }

      // Dispose the current controller
      await cameraController.dispose();

      // Initialize the new camera controller
      cameraController = CameraController(
        newCamera,
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      try {
        await cameraController.initialize();
        _isCameraReady = true;

        // Fetch min and max zoom levels
        _minZoomLevel = await cameraController.getMinZoomLevel();
        _maxZoomLevel = await cameraController.getMaxZoomLevel();

        // Restore flash mode
        await cameraController
            .setFlashMode(_isCameraFlashOn ? FlashMode.torch : FlashMode.off);

        // Reset zoom level
        _currentZoomLevel = _minZoomLevel;
        await cameraController.setZoomLevel(_currentZoomLevel);

        notifyListeners();

        if (wasRecording) {
          await startRecording();
        }
      } on CameraException catch (e) {
        debugPrint("Error switching camera: $e");
        _isCameraReady = false;
        notifyListeners();
      }
    }
  }
  // ======================================================================

  /// Merges all video segments into a single video file using ffmpeg_kit_flutter
  Future<XFile?> mergeVideoSegments() async {
    if (_videoSegments.isEmpty) return null;

    // Create a text file listing all video segments
    final Directory tempDir = await getTemporaryDirectory();
    final File listFile = File('${tempDir.path}/video_list.txt');
    String fileContent = '';
    for (var video in _videoSegments) {
      fileContent += "file '${video.path}'\n";
    }
    await listFile.writeAsString(fileContent);

    // Define the output file
    final String outputPath = '${tempDir.path}/merged_video.mp4';

    // Execute ffmpeg command to concatenate videos
    String ffmpegCommand =
        "-f concat -safe 0 -i ${listFile.path} -c copy $outputPath";

    log("Executing FFmpeg command: $ffmpegCommand");

    await FFmpegKit.execute(ffmpegCommand).then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        log('Video segments merged successfully at $outputPath');
        selectedVideo = XFile(outputPath);
      } else if (ReturnCode.isCancel(returnCode)) {
        log('Video merging was cancelled.');
      } else {
        log('Video merging failed with return code ${returnCode!.getValue()}');
      }
    });

    if (selectedVideo != null) {
      return selectedVideo;
    } else {
      return null;
    }
  }

  /// Resets all values and states
  void resetValues({bool isDisposing = false}) {
    if (_isDisposed) return;
    if (videoController != null) {
      videoController!.pause();
      videoController!.dispose();
    }
    selectedVideo = null;
    videoController = null;
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
    _videoSegments.clear(); // Clear video segments

    if (!isDisposing) {
      notifyListeners();
    }
  }


  /// Toggles the flash mode between on and off
  Future<void> toggleFlash() async {
    if (_isCameraReady) {
      try {
        _isCameraFlashOn = !_isCameraFlashOn;

        if (_isCameraFlashOn) {
          await cameraController.setFlashMode(FlashMode.torch);
          log("Flash ON");
        } else {
          await cameraController.setFlashMode(FlashMode.off);
          log("Flash OFF");
        }
        notifyListeners();
      } catch (e) {
        log('Flash error: $e');
        // Reset flash state if there's an error
        _isCameraFlashOn = false;
        notifyListeners();
      }
    } else {
      log('Camera not ready');
    }
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _zoomDebounceTimer?.cancel(); // Cancel Zoom Debounce Timer
    _isDisposed = true;
    videoController?.dispose();
    cameraController.dispose();
    super.dispose();
  }

  /// Picks a video from the gallery using AssetPicker
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
