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

  bool _isRecording = false;
  bool get isRecording => _isRecording;

  String _recordingDuration = "00:00";
  String get recordingDuration => _recordingDuration;

  Timer? _recordingTimer;
  int _recordingSeconds = 0;

  List<XFile> _videoSegments = [];
  List<XFile> get videoSegments => _videoSegments;

  double _zoomLevel = 1.0;
  double get zoomLevel => _zoomLevel;

  Timer? _zoomDebounceTimer;
  bool _isDisposed = false;

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [Permission.camera].request();
    if (!statuses.values.every((status) => status.isGranted)) {
      throw Exception('Permissions not granted');
    }
  }

  Future<void> initCamera({required CameraDescription description}) async {
    try {
      await requestPermissions();
      cameraController = CameraController(
        description,
        ResolutionPreset.max,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await cameraController.initialize();
      _isCameraReady = true;
      await cameraController.setFlashMode(FlashMode.off);
      _zoomLevel = await cameraController.getMinZoomLevel();
      await cameraController.setZoomLevel(_zoomLevel);
      notifyListeners();
    } catch (e) {
      log("Camera initialization error: $e");
      _isCameraReady = false;
      notifyListeners();
    }
  }

  Future<void> setZoomLevel(double zoom) async {
    if (!_isCameraReady) return;
    _zoomDebounceTimer?.cancel();
    _zoomDebounceTimer = Timer(const Duration(milliseconds: 50), () async {
      try {
        await cameraController.setZoomLevel(zoom);
        _zoomLevel = zoom;
        notifyListeners();
      } catch (e) {
        log('Error setting zoom: $e');
      }
    });
  }

  Future<void> startRecording() async {
    if (_isRecording) return;
    _isRecording = true;
    notifyListeners();
    try {
      await cameraController.startVideoRecording();
      startRecordingTimer();
      log('Recording started');
    } catch (e) {
      log('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (!_isRecording) return;
    _isRecording = false;
    stopRecordingTimer();
    try {
      selectedVideo = await cameraController.stopVideoRecording();
      _videoSegments.add(selectedVideo!);
      notifyListeners();
      log('Recording stopped');
    } catch (e) {
      log('Error stopping recording: $e');
    }
  }

  void startRecordingTimer() {
    _recordingSeconds = 0;
    _recordingDuration = "00:00";
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }
      _recordingSeconds++;
      _recordingDuration = "${(_recordingSeconds ~/ 60).toString().padLeft(2, '0')}:${(_recordingSeconds % 60).toString().padLeft(2, '0')}";
      notifyListeners();
    });
  }

  void stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _recordingSeconds = 0;
    _recordingDuration = "00:00";
    notifyListeners();
  }

  Future<void> toggleFlash() async {
    if (!_isCameraReady) return;
    try {
      bool isFlashOn = (await cameraController.getFlashMode()) == FlashMode.torch;
      await cameraController.setFlashMode(isFlashOn ? FlashMode.off : FlashMode.torch);
      notifyListeners();
    } catch (e) {
      log('Flash toggle error: $e');
    }
  }

  Future<void> flipCamera(List<CameraDescription> cameras) async {
    if (!_isCameraReady) return;
    final lensDirection = cameraController.description.lensDirection;
    CameraDescription? newCamera = cameras.firstWhereOrNull((cam) => cam.lensDirection != lensDirection);
    if (newCamera == null) return;
    await cameraController.dispose();
    await initCamera(description: newCamera);
  }

  Future<XFile?> mergeVideoSegments() async {
    if (_videoSegments.isEmpty) return null;
    final tempDir = await getTemporaryDirectory();
    final listFile = File('${tempDir.path}/video_list.txt');
    await listFile.writeAsString(_videoSegments.map((video) => "file '${video.path}'").join('\n'));
    final outputPath = '${tempDir.path}/merged_video.mp4';
    await FFmpegKit.execute("-f concat -safe 0 -i ${listFile.path} -c copy $outputPath");
    selectedVideo = XFile(outputPath);
    return selectedVideo;
  }

  void resetValues() {
    videoController?.dispose();
    selectedVideo = null;
    videoController = null;
    _recordingSeconds = 0;
    _recordingDuration = "00:00";
    _isRecording = false;
    _videoSegments.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _zoomDebounceTimer?.cancel();
    _isDisposed = true;
    videoController?.dispose();
    cameraController.dispose();
    super.dispose();
  }
}
