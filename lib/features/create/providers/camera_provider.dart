import 'package:socialverse/export.dart';

class CameraProvider extends ChangeNotifier {
  late CameraController cameraController;
  VideoPlayerController? videoController;
  XFile? selectedVideo;
  late bool _isCameraReady;
  late Timer clickTimer;
  late Timer timer;

  List<AssetEntity> _assets = <AssetEntity>[];
  List<AssetEntity> get assets => _assets;

  int _timer_value = 0;
  int get timer_value => _timer_value;

  double _video_speed = 1.0;
  double get video_speed => _video_speed;

  set video_speed(double value) {
    _video_speed = value;
    notifyListeners();
  }

  double _record_percentage = 0.0;
  double get record_percentage => _record_percentage;

  bool _is_timer_selected = true;
  bool get is_timer_selected => _is_timer_selected;

  set is_timer_selected(bool value) {
    _is_timer_selected = value;
    notifyListeners();
  }

  bool _is_camera_flash_on = false;
  bool get is_camera_flash_on => _is_camera_flash_on;

  set is_camera_flash_on(bool value) {
    _is_camera_flash_on = value;
    notifyListeners();
  }

  bool _is_timer_on = false;
  bool get is_timer_on => _is_timer_on;

  set is_timer_on(bool value) {
    _is_timer_on = value;
    notifyListeners();
  }

  bool _is_first_click = false;
  bool get is_first_click => _is_first_click;

  set is_first_click(bool value) {
    _is_first_click = value;
    notifyListeners();
  }

  bool _is_record_start = true;
  bool get is_record_start => _is_record_start;

  set is_record_start(bool value) {
    _is_record_start = value;
    notifyListeners();
  }

  bool _is_video_pause = false;
  bool get is_video_pause => _is_video_pause;

  set is_video_pause(bool value) {
    _is_video_pause = value;
    notifyListeners();
  }

  bool _is_video_record = false;
  bool get is_video_record => _is_video_record;

  set is_video_record(bool value) {
    _is_video_record = value;
    notifyListeners();
  }

  bool _is_camera_flip = false;
  bool get is_camera_flip => _is_camera_flip;

  set is_camera_flip(bool value) {
    _is_camera_flip = value;
    notifyListeners();
  }

  bool _is_timer_count = false;
  bool get is_timer_count => _is_timer_count;

  set is_timer_count(bool value) {
    _is_timer_count = value;
    notifyListeners();
  }

  double _percent_indicator_radius = 40.0;
  double get percent_indicator_radius => _percent_indicator_radius;

  set percent_indicator_radius(double value) {
    _percent_indicator_radius = value;
    notifyListeners();
  }

  double _record_percentage_value = 0.0;
  double get record_percentage_value => _record_percentage_value;

  set record_percentage_value(double value) {
    _record_percentage_value = value;
    notifyListeners();
  }

  double _button_press_size = 50.0;
  double get button_press_size => _button_press_size;

  set button_press_size(double value) {
    _button_press_size = value;
    notifyListeners();
  }

  Future<void> initCamera({required value, required mounted}) async {
    cameraController = CameraController(
      value,
      ResolutionPreset.max,
    );
    try {
      await cameraController.initialize().then((_) {
        _isCameraReady = true;
        if (!mounted) return;
        notifyListeners();
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  void initVideo() {
    if (selectedVideo != null) {
      videoController = VideoPlayerController.file(File(selectedVideo!.path));
      videoController!.addListener(() {
        notifyListeners();
      });
      videoController?.setLooping(true);
      videoController?.initialize().then((_) {
        videoController?.setPlaybackSpeed(_video_speed);
        videoController?.play();
      });
    }
  }

  void flipCamera({required cameras}) {
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

  void startTimerButton() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timerButton) async {
        if (_timer_value == 3.0) {
          is_timer_count = !is_timer_count;

          timerButton.cancel();
          is_timer_selected = false;
          if (_is_camera_flash_on == true) {
            cameraController.setFlashMode(
              FlashMode.torch,
            );
          }
          await cameraController.startVideoRecording();
          startTimer();
          notifyListeners();

          Timer(const Duration(seconds: 30), () async {
            if (_is_video_pause == false) {
              _is_timer_selected = true;
              is_video_record = !_is_video_record;
              if (is_camera_flash_on == true) {
                cameraController.setFlashMode(
                  FlashMode.off,
                );
              }
              selectedVideo = await cameraController.stopVideoRecording();
              initVideo();
              startTimer();
              cameraController.buildPreview();
              notifyListeners();
            }
          });
        } else {
          _timer_value++;
          notifyListeners();
        }
      },
    );
  }

  void startTimer() {
    const duration = Duration(seconds: 1);
    clickTimer = Timer.periodic(
      duration,
      (Timer timer) {
        if (_record_percentage == 30.0 || _is_timer_selected) {
          timer.cancel();
          notifyListeners();
        } else {
          _record_percentage++;
          notifyListeners();
        }
      },
    );
  }

  void toggleFlash() {
    if (_isCameraReady) {
      _is_camera_flash_on = !_is_camera_flash_on;
      cameraController
          .setFlashMode(_is_camera_flash_on ? FlashMode.torch : FlashMode.off);
      notifyListeners();
    }
  }

  void resetValues() {
    selectedVideo = null;
    videoController = null;
    _record_percentage_value = 0.0;
    _timer_value = 0;
    _video_speed = 1.0;
    _is_video_pause = false;
    _is_timer_on = false;
    _is_record_start = true;
    _is_first_click = false;
  }

  Future<void> imagePicker(context) async {
    await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        requestType: RequestType.video,
        maxAssets: 1,
        selectedAssets: _assets,
      ),
    ).then((value) async {
      await value![0].originFile.then((value) {
        selectedVideo = XFile(value!.path);
        initVideo();
        startTimer();
        cameraController.buildPreview();
        notifyListeners();
      });
      return null;
    });
  }
}
