import 'dart:developer';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:socialverse/export.dart';

class CameraProvider extends ChangeNotifier {

  bool _isAnythingNull=false;
  bool get isAnythingNull=>_isAnythingNull;

  set isAnythingNull(bool val){
    if(_isAnythingNull!=val){
      _isAnythingNull=val;
      notifyListeners();
    }
  }


  CameraController? _cameraController;
  CameraController? get cameraController=> _cameraController;


  VideoPlayerController? videoController;

  XFile? selectedVideo;

  bool _isCameraReady = false;
  bool get isCameraReady => _isCameraReady;

  bool _isThroughSingleTap = false;
  bool get isThroughSingleTap => _isThroughSingleTap;

  set isThroughSingleTap(val){
    if(_isThroughSingleTap!=val) {
      _isThroughSingleTap = val;
      notifyListeners();
    }
  }


  List<CameraDescription> _localValue = [];
  List<CameraDescription> get localValue => _localValue;

  set localValue(value){
    _localValue=value;
    notifyListeners();
  }

  bool _isReply=false;
  bool get isReply=> _isReply;

  set isReply(val)=> _isReply=val;


  String _recordingDuration = "00:00";
  String get recordingDuration => _recordingDuration;

  Timer? _recordingTimer;

  int _recordingSeconds = 0;

  String _recordingLastDuration = "00:00";
  String get recordingLastDuration => _recordingLastDuration;

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
    _recordingLastDuration=_recordingDuration;
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
    if(_recordingCompleted!=val){
      _recordingCompleted=val;
      notifyListeners();
    }

  }


  bool _hasPermission=false;
  bool get hasPermission=>_hasPermission;

  set hasPermission(bool val){
    if(hasPermission!=val){
      _hasPermission=val;
      notifyListeners();
    }
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
    if(_pressPosition!=val){
      _pressPosition=val;
      notifyListeners();
    }
  }

  bool _isRecordingLocked = false;
  bool get isRecordingLocked=>_isRecordingLocked;

  set isRecordingLocked(bool val){
    if(_isRecordingLocked!=val){
      _isRecordingLocked=val;
      notifyListeners();
    }
  }

  void toggleRecordingLock() {
    _isRecordingLocked = !_isRecordingLocked;
    notifyListeners();
  }

  bool _isLockIconHovered=false;
  bool get isLockIconHovered => _isLockIconHovered;

  set isLockIconHovered(bool val){
    if(_isLockIconHovered!=val){
      _isLockIconHovered=val;
      notifyListeners();
    }
  }


  List<AssetEntity> _assets = <AssetEntity>[];
  List<AssetEntity> get assets => _assets;

  double _recordPercentage = 0.0;
  double get recordPercentage => _recordPercentage;

  set recordPercentage(double value) {
    if(_recordPercentage!=value){
      _recordPercentage = value;
      notifyListeners();
    }
  }

  bool _isCameraFlashOn = false;
  bool get isCameraFlashOn => _isCameraFlashOn;

  set isCameraFlashOn(bool value) {
    if(_isCameraFlashOn!=value){
      _isCameraFlashOn = value;
      notifyListeners();
    }
  }

  bool _isVideoRecord = false;
  bool get isVideoRecord => _isVideoRecord;

  set isVideoRecord(bool value) {
    if(_isVideoRecord!=value){
      _isVideoRecord = value;
      notifyListeners();
    }
  }

  bool _isRecordStart = true;
  bool get isRecordStart => _isRecordStart;

  set isRecordStart(bool value) {
    if(_isRecordStart!=value){
      _isRecordStart = value;
      notifyListeners();
    }
  }

  double _percentIndicatorRadius = 70.0;
  double get percentIndicatorRadius => _percentIndicatorRadius;

  set percentIndicatorRadius(double value) {
    if(_percentIndicatorRadius!=value){
      _percentIndicatorRadius = value;
      notifyListeners();
    }
  }

  double _buttonPressSize = 50.0;
  double get buttonPressSize => _buttonPressSize;

  set buttonPressSize(double value) {
    if(_buttonPressSize!=value){
      _buttonPressSize = value;
      notifyListeners();
    }
  }

  bool shouldStartRecording = false;

  bool _isRecording=false;

  bool _isCameraFlip = false;
  bool get isCameraFlip => _isCameraFlip;

  set isCameraFlip(bool value) {
    if(_isCameraFlip!=value){
      _isCameraFlip = value;
      notifyListeners();
    }
  }


  bool _isLongPressed = false;
  bool get isLongPressed => _isLongPressed;

  set isLongPressed(bool value) {
    if(_isLongPressed!=value){
      _isLongPressed = value;
      notifyListeners();
    }
  }

  bool _isVideoPause = false;
  bool get isVideoPause => _isVideoPause;

  set isVideoPause(bool value) {
    if(_isVideoPause!=value){
      _isVideoPause = value;
      notifyListeners();
    }
  }

  bool _showCameraScreen = false;
  bool get showCameraScreen => _showCameraScreen;

  set showCameraScreen(bool value) {
    if(_showCameraScreen!=value){
      _showCameraScreen = value;
      notifyListeners();
    }
  }

  double _videoSpeed = 1.0;
  double get videoSpeed => _videoSpeed;

  set videoSpeed(double value) {
    if(_videoSpeed!=value){
      _videoSpeed = value;
      notifyListeners();
    }
  }

  bool _isTimerOn = false;
  bool get isTimerOn => _isTimerOn;

  set isTimerOn(bool value) {
    if(_isTimerOn!=value){
      _isTimerOn = value;
      notifyListeners();
    }

  }

  int _timerValue = 0;
  int get timerValue => _timerValue;

  int _selectedTimerDuration = 0;
  int get selectedTimerDuration => _selectedTimerDuration;

  set selectedTimerDuration(int value) {
    if(_selectedTimerDuration!=value){
      _selectedTimerDuration = value;
      notifyListeners();
    }
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

      if (_cameraController != null) {
        await _cameraController!.dispose();
        _cameraController = null;
      }

      _cameraController = CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: true, // Ensure audio is enabled if needed
        imageFormatGroup:
            ImageFormatGroup.jpeg, // Optional: specify image format
      );

      await _cameraController!.initialize();
      _isCameraReady = true;
      notifyListeners();

      // Initialize flash mode based on current state
      await setFlashMode(false); // Start with flash off

      _isCameraFlashOn = false;

      // Fetch min and max zoom levels
      _minZoomLevel = await _cameraController!.getMinZoomLevel();
      _maxZoomLevel = await _cameraController!.getMaxZoomLevel();

      // Initialize current zoom level
      _currentZoomLevel = _minZoomLevel;
      await _cameraController!.setZoomLevel(_currentZoomLevel);
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
        await _cameraController!.setZoomLevel(newZoom);
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
    _isRecording=true;

    _buttonPressSize = 70;
    _percentIndicatorRadius = 70;
    _isRecordStart = true;
    _isVideoRecord = true;

    if (_isCameraFlashOn) {
      await setFlashMode(true); // This will use torch mode for video
    }

    try {
      await _cameraController!.startVideoRecording();
      log('DEBUG: Recording started');
      startRecordingTimer();
      startProgress();
    } catch (e) {
      log('Error starting video recording: $e');
    }

  }

  /// Stops video recording
  Future<void> stopRecording({bool isFromFlip = false}) async {

    progressReset();

    if (_isCameraFlashOn) {
      await setFlashMode(_isCameraFlashOn); // This will restore appropriate flash mode
    }

    stopRecordingTimer();

    if (!isFromFlip) {
      try {
        XFile? recordedVideo = await _cameraController!.stopVideoRecording();
        selectedVideo = recordedVideo;
        _videoSegments.add(recordedVideo); // Store the segment
        initVideo();
        log('DEBUG: Recording stopped');
      } catch (e) {
        log('Error stopping video recording: $e');
      }
      _recordingCompleted = true;
    } else {
      try {
        XFile? recordedVideo = await _cameraController!.stopVideoRecording();
        if (recordedVideo != null) {
          _videoSegments.clear();  // i dont know let me check after some time
          _videoSegments.add(recordedVideo); // Store the segment even during flip
        }
        log('DEBUG: Recording stopped from flip');
      } catch (e) {
        log('Error stopping video recording during flip: $e');
      }
    }
    _isRecording=false;
  }

  /// Handles recording progress
  void startProgress() {

    _recordPercentage = 0.0;

    Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      _recordPercentage += 0.001667;
      // if stopped recording
      if(!_isRecording) _recordPercentage=1;

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
    _percentIndicatorRadius = 70;
    _buttonPressSize = 50;
    _isRecordStart = false;
    _isVideoRecord = false;
    shouldStartRecording=false;
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

  // ======================== Enhanced flipCamera ========================
  /// Flips the camera between front and back
  Future<void> flipCamera({required List<CameraDescription> cameras}) async {
    // Prevent flip if already in progress
    if (!_isCameraReady || _isCameraFlip) return;

    _isCameraFlip = true;

    try {
      if (_isCameraReady) {
        final lensDirection = _cameraController!.description.lensDirection;
        CameraDescription newCamera;

        try {
          newCamera = cameras.firstWhere(
                (camera) => camera.lensDirection != lensDirection,
          );
        } catch (e) {
          log('No alternative camera found.');
          _isCameraFlip = false;
          return;
        }

        bool wasRecording = _isVideoRecord;

        if (wasRecording) {
          // Stop recording and reset values
          await stopRecording(isFromFlip: true);

          _recordingTimer?.cancel();
          _recordingDuration = "00:00";
          _recordingSeconds = 0;

          // Clear the preview
          if (videoController != null) {
            await videoController!.pause();
            await videoController!.dispose();
            videoController = null;
          }
          selectedVideo = null;
          _recordingCompleted = false;
        }

        // Properly dispose the current controller
        CameraController? oldController;
        if (_cameraController != null) {
          try {
            await _cameraController!.pausePreview();

            // Store old controller for later disposal
            oldController = _cameraController;
            isAnythingNull=true;
            _cameraController = null;
            _isCameraReady = false; // Mark as not ready during transition

          } catch (e) {
            _cameraController = null;
            log('Error disposing camera during flip: $e');
          }
        }

        // Initialize the new camera controller
        _cameraController = CameraController(
          newCamera,
          ResolutionPreset.high,
          enableAudio: true,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );


        // Dispose old controller after new one is created
        if (oldController != null) {
          await oldController.dispose().catchError((e) {
            log('Error disposing old controller: $e');
          });
        }

        isAnythingNull=false;

        try {
          await _cameraController!.initialize();
          _isCameraReady = true;

          // Fetch min and max zoom levels
          _minZoomLevel = await _cameraController!.getMinZoomLevel();
          _maxZoomLevel = await _cameraController!.getMaxZoomLevel();

          // Restore flash mode
          await _cameraController!
              .setFlashMode(_isCameraFlashOn ? FlashMode.torch : FlashMode.off);

          // Reset zoom level
          _currentZoomLevel = _minZoomLevel;
          await _cameraController!.setZoomLevel(_currentZoomLevel);

          notifyListeners();

          if (wasRecording) {
            // Reset necessary values before starting new recording
            _recordPercentage = 0.0;
            _buttonPressSize = 70;
            _percentIndicatorRadius = 70;
            _isRecordStart = true;
            _isVideoRecord = true;

            // Start new recording
            await startRecording();
            startRecordingTimer();
          }
        } on CameraException catch (e) {
          debugPrint("Error switching camera: $e");
          _isCameraReady = false;
          notifyListeners();
        }
      }
    } finally {
      _isCameraFlip = false;
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


  Future<void> resetValues({bool isDisposing = false}) async {

    if (_isDisposed) return;

    if(_isRecording) return;


    // Cancel timers first
    _recordingTimer?.cancel();
    _zoomDebounceTimer?.cancel();

    // handle video controller
    if (videoController != null) {
      await videoController!.pause();
      await videoController!.dispose();
      videoController = null;
    }

    // Reset all state variables
    selectedVideo = null;
    _recordingSeconds = 0;
    _recordingDuration = "00:00";
    _recordingLastDuration = "00:00";
    _videoSpeed = 1.0;
    _isCameraFlip = false;
    _isVideoPause = false;
    _isRecordStart = true;
    _isVideoRecord = false;
    _buttonPressSize = 50.0;
    _recordPercentage = 0.0;
    _percentIndicatorRadius = 70.0;
    _isReply = false;
    _localValue = [];
    _recordingCompleted = false;
    _videoSegments.clear();

    // Comprehensive reset of camera state
    _isCameraReady = false;
    shouldStartRecording = false;
    _isThroughSingleTap = false;
    _isRecordingLocked = false;
    _isLockIconHovered = false;
    _isCameraFlashOn = false;
    _isAnythingNull = false;

    // Dispose camera controller properly
    try {
      if (_cameraController != null) {
        Future.microtask(() async{
          var _oldCameraController= _cameraController;
          _cameraController = null;
          notifyListeners();
          await _oldCameraController!.pausePreview();
          await _oldCameraController!.dispose();
          _oldCameraController=null;
        }).then((value) => notifyListeners());

      }
    } catch (e) {
      log('Error disposing camera controller: $e');
    }

    _showCameraScreen = false;

    if (!isDisposing) {
      notifyListeners();
    }


  }



  /// Toggles the flash mode between on and off
  Future<void> toggleFlash() async {
    if (!_isCameraReady || _cameraController == null) {
      log('Camera not ready for flash toggle');
      return;
    }

    try {
      _isCameraFlashOn = !_isCameraFlashOn;

      if (_isVideoRecord || _isRecording) {
        // Use torch mode for video recording
        await _cameraController!.setFlashMode(
            _isCameraFlashOn ? FlashMode.torch : FlashMode.off
        );
      } else {
        // Use regular flash mode for photos
        await _cameraController!.setFlashMode(
            _isCameraFlashOn ? FlashMode.always : FlashMode.off
        );
      }

      log("Flash ${_isCameraFlashOn ? 'ON' : 'OFF'}");
      notifyListeners();

    } catch (e) {
      log('Flash error: $e');
      // Revert flash state on error
      _isCameraFlashOn = !_isCameraFlashOn;

      // Try to ensure flash is off on error
      try {
        await _cameraController!.setFlashMode(FlashMode.off);
      } catch (_) {
        // Ignore secondary error
      }

      notifyListeners();
    }
  }

  /// Sets flash mode explicitly - useful when initializing camera
  Future<void> setFlashMode(bool enabled) async {
    if (!_isCameraReady || _cameraController == null) return;

    try {
      _isCameraFlashOn = enabled;

      if (_isVideoRecord || _isRecording) {
        await _cameraController!.setFlashMode(
            enabled ? FlashMode.torch : FlashMode.off
        );
      } else {
        await _cameraController!.setFlashMode(
            enabled ? FlashMode.always : FlashMode.off
        );
      }

      notifyListeners();
    } catch (e) {
      log('Error setting flash mode: $e');
      _isCameraFlashOn = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _zoomDebounceTimer?.cancel(); // Cancel Zoom Debounce Timer
    _isDisposed = true;
    videoController?.dispose();
    _cameraController!.dispose();
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
            _cameraController!.buildPreview();
            notifyListeners();
          }
        });
      }
    });
  }
}




// import 'dart:developer';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:socialverse/export.dart';
//
// class CameraProvider extends ChangeNotifier {
//   // Camera Controllers
//   CameraController? _cameraController;
//   CameraController? get cameraController => _cameraController;
//   VideoPlayerController? videoController;
//   XFile? selectedVideo;
//
//   // Camera States
//   bool _isCameraReady = false;
//   bool get isCameraReady => _isCameraReady;
//
//   bool _isThroughSingleTap = false;
//   bool get isThroughSingleTap => _isThroughSingleTap;
//   set isThroughSingleTap(val) {
//     if (_isThroughSingleTap != val) {
//       _isThroughSingleTap = val;
//       notifyListeners();
//     }
//   }
//
//   // Local Values
//   List<CameraDescription> _localValue = [];
//   List<CameraDescription> get localValue => _localValue;
//   set localValue(value) {
//     if (_localValue != value) {
//       _localValue = value;
//       notifyListeners();
//     }
//   }
//
//   // Reply State
//   bool _isReply = false;
//   bool get isReply => _isReply;
//   set isReply(val) => _isReply = val;
//
//   // Recording Timer Variables
//   String _recordingDuration = "00:00";
//   String get recordingDuration => _recordingDuration;
//   Timer? _recordingTimer;
//   int _recordingSeconds = 0;
//   String _recordingLastDuration = "00:00";
//   String get recordingLastDuration => _recordingLastDuration;
//
//   // Start recording timer with improved efficiency
//   void startRecordingTimer() {
//     if (_recordingTimer?.isActive ?? false) {
//       _recordingTimer!.cancel();
//     }
//     _recordingSeconds = 0;
//     _recordingDuration = "00:00";
//
//     _recordingTimer = Timer.periodic(
//       const Duration(milliseconds: 100), // Changed to milliseconds for more precision
//           (Timer timer) {
//         if (_recordingSeconds >= 0) {  // Added check to prevent negative values
//           final minutes = (_recordingSeconds ~/ 60).toString().padLeft(2, '0');
//           final seconds = (_recordingSeconds % 60).toString().padLeft(2, '0');
//           _recordingDuration = "$minutes:$seconds";
//           _recordingSeconds++;
//           notifyListeners();
//         }
//       },
//     );
//   }
//
//   // Stop recording timer with cleanup
//   void stopRecordingTimer() {
//     _recordingLastDuration = _recordingDuration;
//     _recordingTimer?.cancel();
//     _recordingTimer = null;
//     _recordingSeconds = 0;
//     _recordingDuration = "00:00";
//     notifyListeners();
//   }
//
//   // State Management
//   bool _isDisposed = false;
//   bool _recordingCompleted = false;
//   bool get recordingCompleted => _recordingCompleted;
//   set recordingCompleted(bool val) {
//     if (_recordingCompleted != val) {
//       _recordingCompleted = val;
//       notifyListeners();
//     }
//   }
//
//   // Permission Management
//   bool _hasPermission = false;
//   bool get hasPermission => _hasPermission;
//   set hasPermission(bool val) {
//     if (_hasPermission != val) {
//       _hasPermission = val;
//       notifyListeners();
//     }
//   }
//
//   // Position Management
//   Offset? _pressPosition;
//   Offset? get pressPosition => _pressPosition;
//   set pressPosition(Offset? val) {
//     if (_pressPosition != val) {
//       _pressPosition = val;
//       notifyListeners();
//     }
//   }
//
//   // Recording Lock Management
//   bool _isRecordingLocked = false;
//   bool get isRecordingLocked => _isRecordingLocked;
//   set isRecordingLocked(bool val) {
//     if (_isRecordingLocked != val) {
//       _isRecordingLocked = val;
//       notifyListeners();
//     }
//   }
//
//   void toggleRecordingLock() {
//     _isRecordingLocked = !_isRecordingLocked;
//     notifyListeners();
//   }
//
//   // Lock Icon State
//   bool _isLockIconHovered = false;
//   bool get isLockIconHovered => _isLockIconHovered;
//   set isLockIconHovered(bool val) {
//     if (_isLockIconHovered != val) {
//       _isLockIconHovered = val;
//       notifyListeners();
//     }
//   }
//
//   // Asset Management
//   List<AssetEntity> _assets = <AssetEntity>[];
//   List<AssetEntity> get assets => _assets;
//
//   // Recording Progress Management
//   double _recordPercentage = 0.0;
//   double get recordPercentage => _recordPercentage;
//   set recordPercentage(double value) {
//     if (_recordPercentage != value) {
//       _recordPercentage = value;
//       notifyListeners();
//     }
//   }
//
//   // Camera Flash Management
//   bool _isCameraFlashOn = false;
//   bool get isCameraFlashOn => _isCameraFlashOn;
//   set isCameraFlashOn(bool value) {
//     if (_isCameraFlashOn != value) {
//       _isCameraFlashOn = value;
//       notifyListeners();
//     }
//   }
//
//   // Video Recording State Management
//   bool _isVideoRecord = false;
//   bool get isVideoRecord => _isVideoRecord;
//   set isVideoRecord(bool value) {
//     if (_isVideoRecord != value) {
//       _isVideoRecord = value;
//       notifyListeners();
//     }
//   }
//
//   // Record Start State
//   bool _isRecordStart = true;
//   bool get isRecordStart => _isRecordStart;
//   set isRecordStart(bool value) {
//     if (_isRecordStart != value) {
//       _isRecordStart = value;
//       notifyListeners();
//     }
//   }
//
//   // UI Size Management
//   double _percentIndicatorRadius = 70.0;
//   double get percentIndicatorRadius => _percentIndicatorRadius;
//   set percentIndicatorRadius(double value) {
//     if (_percentIndicatorRadius != value) {
//       _percentIndicatorRadius = value;
//       notifyListeners();
//     }
//   }
//
//   double _buttonPressSize = 50.0;
//   double get buttonPressSize => _buttonPressSize;
//   set buttonPressSize(double value) {
//     if (_buttonPressSize != value) {
//       _buttonPressSize = value;
//       notifyListeners();
//     }
//   }
//
//   // Recording Control
//   bool shouldStartRecording = false;
//
//   // Camera Flip State
//   bool _isCameraFlip = false;
//   bool get isCameraFlip => _isCameraFlip;
//   set isCameraFlip(bool value) {
//     if (_isCameraFlip != value) {
//       _isCameraFlip = value;
//       notifyListeners();
//     }
//   }
//
//   // Long Press State
//   bool _isLongPressed = false;
//   bool get isLongPressed => _isLongPressed;
//   set isLongPressed(bool value) {
//     if (_isLongPressed != value) {
//       _isLongPressed = value;
//       notifyListeners();
//     }
//   }
//
//   // Video Pause State
//   bool _isVideoPause = false;
//   bool get isVideoPause => _isVideoPause;
//   set isVideoPause(bool value) {
//     if (_isVideoPause != value) {
//       _isVideoPause = value;
//       notifyListeners();
//     }
//   }
//
//   // Camera Screen State
//   bool _showCameraScreen = false;
//   bool get showCameraScreen => _showCameraScreen;
//   set showCameraScreen(bool value) {
//     if (_showCameraScreen != value) {
//       _showCameraScreen = value;
//       notifyListeners();
//     }
//   }
//
//   // Video Speed Management
//   double _videoSpeed = 1.0;
//   double get videoSpeed => _videoSpeed;
//   set videoSpeed(double value) {
//     if (_videoSpeed != value) {
//       _videoSpeed = value;
//       notifyListeners();
//     }
//   }
//
//   // Timer Management
//   bool _isTimerOn = false;
//   bool get isTimerOn => _isTimerOn;
//   set isTimerOn(bool value) {
//     if (_isTimerOn != value) {
//       _isTimerOn = value;
//       notifyListeners();
//     }
//   }
//
//   int _timerValue = 0;
//   int get timerValue => _timerValue;
//
//   int _selectedTimerDuration = 0;
//   int get selectedTimerDuration => _selectedTimerDuration;
//   set selectedTimerDuration(int value) {
//     if (_selectedTimerDuration != value) {
//       _selectedTimerDuration = value;
//       notifyListeners();
//     }
//   }
//
//   // Zoom Management
//   double _currentZoomLevel = 1.0;
//   double get currentZoomLevel => _currentZoomLevel;
//   set currentZoomLevel(double val) => _currentZoomLevel = val;
//
//   double _minZoomLevel = 1.0;
//   double get minZoomLevel => _minZoomLevel;
//
//   double _maxZoomLevel = 1.0;
//   double get maxZoomLevel => _maxZoomLevel;
//
//   Timer? _zoomDebounceTimer;
//
//   // Video Segments Management
//   List<XFile> _videoSegments = [];
//   List<XFile> get videoSegments => _videoSegments;
//
//   // Enhanced Permission Management
//   Future<void> requestPermissions() async {
//     try {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.camera,
//       ].request();
//
//       bool allGranted = statuses.values.every((status) => status.isGranted);
//       if (!allGranted) {
//         throw Exception('Permissions not granted');
//       }
//       _hasPermission = true;
//     } catch (e) {
//       _hasPermission = false;
//       log('Permission error: $e');
//       throw Exception('Permission error: $e');
//     }
//   }
//
//   // Initialize Camera with Error Handling
//
//   // Optimized Zoom Control
//   Future<void> setZoomLevel(double zoom) async {
//     if (!_isCameraReady) return;
//
//     final newZoom = zoom.clamp(_minZoomLevel, _maxZoomLevel);
//     _zoomDebounceTimer?.cancel();
//
//     _zoomDebounceTimer = Timer(const Duration(milliseconds: 50), () async {
//       try {
//         await _cameraController!.setZoomLevel(newZoom);
//         _currentZoomLevel = newZoom;
//         notifyListeners();
//       } catch (e) {
//         log('Error setting zoom level: $e');
//       }
//     });
//   }
//
//   // Enhanced Recording Management
//   Future<void> startRecording() async {
//     _buttonPressSize = 70;
//     _percentIndicatorRadius = 70;
//     _isRecordStart = true;
//     _isVideoRecord = true;
//
//     try {
//       if (_isCameraFlashOn) {
//         await _cameraController!.setFlashMode(FlashMode.torch);
//       }
//
//       await _cameraController!.startVideoRecording();
//       log('DEBUG: Recording started');
//       startRecordingTimer();
//       startProgress();
//     } catch (e) {
//       log('Error starting video recording: $e');
//       _isVideoRecord = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> stopRecording({bool isFromFlip = false}) async {
//     if (!_isVideoRecord) return; // Prevent multiple stops
//
//     try {
//       progressReset();
//
//       if (_isCameraFlashOn) {
//         await _cameraController?.setFlashMode(FlashMode.off);
//       }
//
//       stopRecordingTimer();
//
//       // Ensure minimum recording duration (e.g., 1 second)
//       if (_recordingSeconds < 1) {
//         await Future.delayed(Duration(milliseconds: (1 - _recordingSeconds) * 1000));
//       }
//
//       if (!isFromFlip) {
//         if (_cameraController != null) {
//           XFile? recordedVideo = await _cameraController!.stopVideoRecording();
//           if (recordedVideo != null) {
//             selectedVideo = recordedVideo;
//             _videoSegments.add(recordedVideo);
//             await initVideo(); // Wait for video initialization
//             log('DEBUG: Recording stopped');
//             _recordingCompleted = true;
//           }
//         }
//       } else {
//         if (_cameraController != null) {
//           XFile? recordedVideo = await _cameraController!.stopVideoRecording();
//           if (recordedVideo != null) {
//             _videoSegments.add(recordedVideo);
//           }
//           log('DEBUG: Recording stopped from flip');
//         }
//       }
//     } catch (e) {
//       log('Error stopping video recording: $e');
//     }
//   }
//
//   // Progress Management
//   void startProgress() {
//     _recordPercentage = 0.0;
//     const progressIncrement = 0.005;
//
//     Timer.periodic(const Duration(milliseconds: 100), (timer) async {
//       _recordPercentage += progressIncrement;
//       if (_recordPercentage >= 1.0) {
//         _recordPercentage = 1.0;
//         timer.cancel();
//         if (_isVideoRecord) {
//           await stopRecording();
//         }
//       }
//       notifyListeners();
//     });
//   }
//
//   void stopProgress() {
//     _recordPercentage = 0.0;
//     notifyListeners();
//   }
//
//   void progressReset() {
//     _recordPercentage = 0.0;
//     _percentIndicatorRadius = 70;
//     _buttonPressSize = 50;
//     _isRecordStart = false;
//     _isVideoRecord = false;
//     shouldStartRecording = false;
//     notifyListeners();
//   }
//
//
//
//   Future<void> initCamera({
//     required CameraDescription description,
//     required bool mounted,
//   }) async {
//     try {
//       await requestPermissions();
//
//       // Properly dispose of existing controller
//       if (_cameraController != null) {
//         final temp = _cameraController;
//         _cameraController = null;
//         await temp?.dispose();
//       }
//
//       _isCameraReady = false; // Reset camera ready state
//       notifyListeners();
//
//       // Initialize new controller
//       _cameraController = CameraController(
//         description,
//         ResolutionPreset.high,
//         enableAudio: true,
//         imageFormatGroup: ImageFormatGroup.jpeg,
//       );
//
//       // Wait for controller to initialize
//       await _cameraController!.initialize();
//
//       if (!mounted) return; // Check if widget is still mounted
//
//       // Configure camera settings
//       await Future.wait([
//         _cameraController!.setFlashMode(FlashMode.off),
//         _cameraController!.lockCaptureOrientation(),
//       ]);
//
//       _minZoomLevel = await _cameraController!.getMinZoomLevel();
//       _maxZoomLevel = await _cameraController!.getMaxZoomLevel();
//       _currentZoomLevel = _minZoomLevel;
//       await _cameraController!.setZoomLevel(_currentZoomLevel);
//
//       _isCameraReady = true;
//       _isCameraFlashOn = false;
//
//       if (shouldStartRecording) {
//         await startRecording();
//         shouldStartRecording = false;
//       }
//
//       notifyListeners();
//     } catch (e) {
//       log('Camera initialization error: $e');
//       _isCameraReady = false;
//       notifyListeners();
//       rethrow; // Rethrow to handle in UI
//     }
//   }
//
//   // Improved video initialization
//   Future<void> initVideo() async {
//     if (selectedVideo == null) return;
//
//     try {
//       if (videoController != null) {
//         await videoController!.dispose();
//         videoController = null;
//       }
//
//       videoController = VideoPlayerController.file(File(selectedVideo!.path));
//
//       // Wait for controller to initialize
//       await videoController!.initialize();
//
//       // Configure video settings
//       videoController!.addListener(notifyListeners);
//       await videoController!.setLooping(true);
//       await videoController!.setPlaybackSpeed(_videoSpeed);
//       await videoController!.play();
//
//       notifyListeners();
//     } catch (e) {
//       log('Error initializing video: $e');
//       videoController = null;
//     }
//   }
//
//
//
//
//
//   // Enhanced Camera Flip
//   Future<void> flipCamera({required List<CameraDescription> cameras}) async {
//     if (!_isCameraReady) return;
//
//     try {
//       final lensDirection = _cameraController!.description.lensDirection;
//       final newCamera = cameras.firstWhere(
//             (camera) => camera.lensDirection != lensDirection,
//       );
//
//       final wasRecording = _isVideoRecord;
//
//       // Enhanced Camera Flip - Continued
//       if (wasRecording) {
//         await stopRecording(isFromFlip: true);
//         progressReset();
//         _recordingTimer?.cancel();
//         _recordingDuration = "00:00";
//         _recordingSeconds = 0;
//
//         if (videoController != null) {
//           await videoController!.pause();
//           await videoController!.dispose();
//           videoController = null;
//         }
//         selectedVideo = null;
//         _recordingCompleted = false;
//       }
//
//       // Properly dispose current controller
//       if (_cameraController != null) {
//         try {
//           await _cameraController!.pausePreview();
//           final temp = _cameraController!;
//           _cameraController = null;
//           await temp.dispose();
//         } catch (e) {
//           log('Error disposing camera during flip: $e');
//         }
//       }
//
//       // Initialize new camera controller with proper error handling
//       _cameraController = CameraController(
//         newCamera,
//         ResolutionPreset.high,
//         enableAudio: true,
//         imageFormatGroup: ImageFormatGroup.jpeg,
//       );
//
//       try {
//         await _cameraController!.initialize();
//         _isCameraReady = true;
//
//         _minZoomLevel = await _cameraController!.getMinZoomLevel();
//         _maxZoomLevel = await _cameraController!.getMaxZoomLevel();
//
//         await _cameraController!.setFlashMode(_isCameraFlashOn ? FlashMode.torch : FlashMode.off);
//
//         _currentZoomLevel = _minZoomLevel;
//         await _cameraController!.setZoomLevel(_currentZoomLevel);
//
//         if (wasRecording) {
//           _recordPercentage = 0.0;
//           _buttonPressSize = 70;
//           _percentIndicatorRadius = 70;
//           _isRecordStart = true;
//           _isVideoRecord = true;
//
//           await startRecording();
//           startRecordingTimer();
//         }
//
//         notifyListeners();
//       } catch (e) {
//         _isCameraReady = false;
//         log('Error initializing flipped camera: $e');
//         notifyListeners();
//       }
//     } catch (e) {
//       log('Error during camera flip: $e');
//     }
//   }
//
//   // Optimized Video Segment Merging
//   Future<XFile?> mergeVideoSegments() async {
//     if (_videoSegments.isEmpty) return null;
//
//     try {
//       final Directory tempDir = await getTemporaryDirectory();
//       final File listFile = File('${tempDir.path}/video_list.txt');
//
//       final fileContent = _videoSegments
//           .map((video) => "file '${video.path}'")
//           .join('\n');
//
//       await listFile.writeAsString(fileContent);
//       final String outputPath = '${tempDir.path}/merged_video.mp4';
//       final String ffmpegCommand = "-f concat -safe 0 -i ${listFile.path} -c copy $outputPath";
//
//       final session = await FFmpegKit.execute(ffmpegCommand);
//       final returnCode = await session.getReturnCode();
//
//       if (ReturnCode.isSuccess(returnCode)) {
//         log('Video segments merged successfully at $outputPath');
//         selectedVideo = XFile(outputPath);
//         return selectedVideo;
//       } else {
//         log('Video merging failed with return code ${returnCode!.getValue()}');
//         return null;
//       }
//     } catch (e) {
//       log('Error merging video segments: $e');
//       return null;
//     }
//   }
//
//   // Enhanced Reset Values with proper cleanup
//   Future<void> resetValues({bool isDisposing = false}) async {
//     if (_isDisposed) return;
//
//     try {
//       // Cancel timers first
//       _recordingTimer?.cancel();
//       _zoomDebounceTimer?.cancel();
//
//       // Handle video controller
//       if (videoController != null) {
//         final tempVideoController = videoController;
//         videoController = null;
//         await tempVideoController!.dispose();
//       }
//
//       // Handle camera controller
//       if (_cameraController != null) {
//         final tempCameraController = _cameraController;
//         _cameraController = null;
//
//         try {
//           await tempCameraController!.pausePreview();
//           await tempCameraController.dispose();
//         } catch (e) {
//           log('Error disposing camera controller: $e');
//         }
//       }
//
//       // Reset all state variables
//       selectedVideo = null;
//       _recordingSeconds = 0;
//       _recordingDuration = "00:00";
//       _recordingLastDuration = "00:00";
//       _videoSpeed = 1.0;
//       _isCameraFlip = false;
//       _isVideoPause = false;
//       _isRecordStart = true;
//       _isVideoRecord = false;
//       _buttonPressSize = 50.0;
//       _recordPercentage = 0.0;
//       _percentIndicatorRadius = 70.0;
//       _isReply = false;
//       _localValue = [];
//       _recordingCompleted = false;
//       _videoSegments.clear();
//       _isCameraReady = false;
//       shouldStartRecording = false;
//       _isThroughSingleTap = false;
//       _isRecordingLocked = false;
//       _isLockIconHovered = false;
//       _isCameraFlashOn = false;
//       _showCameraScreen = false;
//
//       if (!isDisposing) {
//         notifyListeners();
//       }
//     } catch (e) {
//       log('Error during reset: $e');
//     }
//   }
//
//   // Enhanced Flash Toggle with Error Handling
//   Future<void> toggleFlash() async {
//     if (!_isCameraReady) {
//       log('Camera not ready');
//       return;
//     }
//
//     try {
//       _isCameraFlashOn = !_isCameraFlashOn;
//       await _cameraController!.setFlashMode(
//           _isCameraFlashOn ? FlashMode.torch : FlashMode.off
//       );
//       log(_isCameraFlashOn ? "Flash ON" : "Flash OFF");
//       notifyListeners();
//     } catch (e) {
//       log('Flash error: $e');
//       _isCameraFlashOn = false;
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     _isDisposed = true;
//     _recordingTimer?.cancel();
//     _zoomDebounceTimer?.cancel();
//
//     if (videoController != null) {
//       videoController!.dispose();
//       videoController = null;
//     }
//
//     if (_cameraController != null) {
//       _cameraController!.dispose();
//       _cameraController = null;
//     }
//
//     super.dispose();
//   }
//
//   // Enhanced Image Picker with Error Handling
//   Future<void> imagePicker(BuildContext context) async {
//     try {
//       final value = await AssetPicker.pickAssets(
//         context,
//         pickerConfig: AssetPickerConfig(
//           requestType: RequestType.video,
//           maxAssets: 1,
//           selectedAssets: _assets,
//         ),
//       );
//
//       if (value != null && value.isNotEmpty) {
//         final file = await value[0].originFile;
//         if (file != null) {
//           selectedVideo = XFile(file.path);
//           initVideo();
//           await _cameraController?.buildPreview();
//           notifyListeners();
//         }
//       }
//     } catch (e) {
//       log('Error picking image: $e');
//     }
//   }
// }





