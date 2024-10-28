import 'package:socialverse/export.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        return CircularPercentIndicator(
          radius: 50,
          lineWidth: 5.0,
          backgroundColor:__.is_record_start ?  Colors.white : Theme.of(context).hintColor,
          percent: (__.record_percentage_value * 3.33) / 100,
          progressColor: Theme.of(context).hintColor,
          animation: true,
          addAutomaticKeepAlive: true,
          animationDuration: 1000,
          animateFromLastPercent: true,
          center: GestureDetector(
            onTap: () async {
              if (__.is_timer_on == true) {
                if (__.is_first_click == false) {
                  __.button_press_size = 70;
                  __.percent_indicator_radius = 50;
                  __.is_record_start = !__.is_record_start;
                  __.is_timer_count = !__.is_timer_count;
                  __.is_video_record = !__.is_video_record;
                  __.startTimerButton();
                  __.is_first_click = !__.is_first_click;
                } else {
                  __.is_video_pause = !__.is_video_pause;
                  __.is_video_record = !__.is_video_record;
                  __.is_timer_selected = true;
                  if (__.is_camera_flash_on == true) {
                    __.cameraController.setFlashMode(
                      FlashMode.off,
                    );
                  }
                  __.selectedVideo =
                      await __.cameraController.stopVideoRecording();
                  __.initVideo();
                  __.stopRecordingTimer();
                  __.cameraController.buildPreview();
                }
              }
            },
            onLongPress: () async {
              if (__.is_timer_on == false) {
                __.button_press_size = 70;
                __.percent_indicator_radius = 50;
                __.is_record_start = !__.is_record_start;
                __.is_timer_selected = false;
                __.is_video_record = !__.is_video_record;
                __.startRecordingTimer();
                if (__.is_camera_flash_on == true) {
                  __.cameraController.setFlashMode(
                    FlashMode.torch,
                  );
                }
                await __.cameraController.startVideoRecording();
              }
            },
            onLongPressCancel: () async {
              if (__.is_timer_on == false) {
                __.percent_indicator_radius = 40;
                __.button_press_size = 50;
                __.is_timer_selected = true;
                __.is_video_record = !__.is_video_record;
                if (__.is_camera_flash_on == true) {
                  __.cameraController.setFlashMode(
                    FlashMode.off,
                  );
                }
                __.stopRecordingTimer();
                __.selectedVideo = await __.cameraController
                    .stopVideoRecording()
                    .then((value) => XFile(value.path));
                __.initVideo();

                __.cameraController.buildPreview();
              }
            },
            // onLongPressEnd: (value) async {
            //   if (__.is_timer_on == false) {
            //     __.percent_indicator_radius = 40;
            //     __.button_press_size = 50;
            //     __.is_timer_selected = true;
            //     __.is_video_record = !__.is_video_record;
            //     if (__.is_camera_flash_on == true) {
            //       __.cameraController.setFlashMode(
            //         FlashMode.off,
            //       );
            //     }
            //     __.selectedVideo =
            //         await __.cameraController.stopVideoRecording();
            //     __.initVideo();
            //     __.startTimer();
            //     __.cameraController.buildPreview();
            //   }
            // },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 86,
                  width: 86,
                  decoration
                      : BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.white10,
                  Colors.white12,
                  Colors.white38,
                ],
                stops: [0.5, 0.6,0.7, 1.0],
              ),
            ),
                ),
                Container(
                  height: 56,
                  width: 56,
                  decoration
                      : BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  decoration
                      : BoxDecoration(
                    shape: __.is_record_start ? BoxShape.circle : BoxShape.rectangle ,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
