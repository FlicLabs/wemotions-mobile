import 'package:socialverse/export.dart';

class CameraProvider extends ChangeNotifier {
  late CameraController cameraController;
  VideoPlayerController? videoController;
  XFile? selectedVideo;
  late bool _isCameraReady;
  late Timer timer;
  String _recordingDuration = "00:00";
  String get recordingDuration => _recordingDuration;

  Timer? _recordingTimer;
  int _recordingSeconds = 0;
  bool _isDisposed = false;

  List<AssetEntity> _assets = <AssetEntity>[];
  List<AssetEntity> get assets => _assets;

  int _timer_value = 0;
  int get timer_value => _timer_value;

  int _selectedTimerDuration = 0;
  int get selectedTimerDuration => _selectedTimerDuration;

  set selectedTimerDuration(int value) {
    _selectedTimerDuration = value;
    notifyListeners();
  }

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

  double _percent_indicator_radius = 70.0;
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
      enableAudio: true,  // Make sure audio is enabled if needed
    );

    try {
      await cameraController.initialize().then((_) {
        _isCameraReady = true;
        if (!mounted) return;
        notifyListeners();
      });

      // Make sure flash is initially off
      await cameraController.setFlashMode(FlashMode.off);
      _is_camera_flash_on = false;

    } on CameraException catch (e) {
      debugPrint("camera error $e");
      _isCameraReady = false;
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

  Future<void> showTimerSelectionDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(

          backgroundColor: Colors.transparent,
          child: Container(
            width: 304, // Set your custom width here
            constraints: BoxConstraints(maxHeight: 400,minHeight: 80),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(onTap:(){
                    selectedTimerDuration = 0;
                    Navigator.pop(context);},child: Icon(Icons.block, color: Colors.white,size: 30,)),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      selectedTimerDuration = 3;
                      Navigator.pop(context);
                    },
                    child: Text(
                      "3SC",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      selectedTimerDuration = 5;
                      Navigator.pop(context);
                    },
                    child: Text(
                      "5SC",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      selectedTimerDuration = 10;
                      Navigator.pop(context);
                    },
                    child: Text(
                      "10SC",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    notifyListeners();
  }

  void startRecordingTimer() {
    _recordingSeconds = 0;
    _recordingDuration = "00:00";

    _recordingTimer?.cancel();

    if (!_isDisposed) {
      _recordingTimer = Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) {
          if (!_isDisposed) {
            _recordingSeconds++;

            // Format minutes and seconds
            final minutes = (_recordingSeconds ~/ 60).toString().padLeft(2, '0');
            final seconds = (_recordingSeconds % 60).toString().padLeft(2, '0');

            _recordingDuration = "$minutes:$seconds";
            print("crop");
            print(_recordingDuration);
            notifyListeners();
          } else {
            timer.cancel();
          }
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
      // Only notify if not disposed
      if (!_isDisposed) {
        notifyListeners();
      }
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
    _timer_value = 0; // Reset timer value

    timer = Timer.periodic(
      oneSec,
          (Timer timerButton) async {
        if (_isDisposed) {
          timerButton.cancel();
          return;
        }

        if (_timer_value == _selectedTimerDuration) {
          is_timer_count = !is_timer_count;

          timerButton.cancel();
          is_timer_selected = false;
          if (_is_camera_flash_on == true) {
            cameraController.setFlashMode(
              FlashMode.torch,
            );
          }
          await cameraController.startVideoRecording();
          if (!_isDisposed) {
            startRecordingTimer();
            notifyListeners();
          }

          Timer(const Duration(seconds: 30), () async {
            if (_isDisposed) return;

            if (_is_video_pause == false) {
              _is_timer_selected = true;
              is_video_record = !_is_video_record;
              if (is_camera_flash_on == true) {
                cameraController.setFlashMode(
                  FlashMode.off,
                );
              }
              stopRecordingTimer();
              selectedVideo = await cameraController.stopVideoRecording();
              if (!_isDisposed) {
                initVideo();
                cameraController.buildPreview();
                notifyListeners();
              }
            }
          });
        } else {
          _timer_value++;
          if (!_isDisposed) {
            notifyListeners();
          }
        }
      },
    );
  }


  void resetValues() {
    if (_isDisposed) return;
    if(videoController != null){
      videoController!.pause();
      videoController!.dispose();
    }
    selectedVideo = null;
    videoController = null;
    _record_percentage_value = 0.0;
    _timer_value = 0;
    _video_speed = 1.0;
    _is_camera_flip = false;
    _is_video_pause = false;
    _is_timer_on = true;
    _is_record_start = true;
    _is_first_click = false;
    _selectedTimerDuration = 3; // Reset to default timer duration
    _recordingTimer?.cancel();
    _recordingTimer = null;
    _recordingSeconds = 0;
    _recordingDuration = "00:00";
  }

  // void startTimer() {
  //   const duration = Duration(seconds: 1);
  //   clickTimer = Timer.periodic(
  //     duration,
  //     (Timer timer) {
  //       if (_record_percentage == 30.0 || _is_timer_selected) {
  //         timer.cancel();
  //         notifyListeners();
  //       } else {
  //         _record_percentage++;
  //         notifyListeners();
  //       }
  //     },
  //   );
  // }

  Future<void> toggleFlash() async {
    if (_isCameraReady) {
      try {
        _is_camera_flash_on = !_is_camera_flash_on;
        notifyListeners(); // Notify first for immediate UI update

        if (_is_camera_flash_on) {
          await cameraController.setFlashMode(FlashMode.torch);
          print("Flash ON"); // Debug print
        } else {
          await cameraController.setFlashMode(FlashMode.off);
          print("Flash OFF"); // Debug print
        }
      } catch (e) {
        print('Flash error: $e');
        // Reset flash state if there's an error
        _is_camera_flash_on = false;
        notifyListeners();
      }
    } else {
      print('Camera not ready'); // Debug print
    }
  }


  @override
  void dispose() {
    _recordingTimer?.cancel();
    super.dispose();
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
        // startTimer();
        cameraController.buildPreview();
        notifyListeners();
      });
      return null;
    });
  }
}
