// ignore_for_file: must_be_immutable
import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

import '../../../core/configs/page_routers/slide_route.dart';
import '../widgets/circular_button.dart';

class CameraScreenArgs {
  bool isReply;
  int? parent_video_id;
  final List<CameraDescription>? cameras;
  CameraScreenArgs({
    this.cameras,
    required this.isReply,
    this.parent_video_id,
  });
}

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera';

  CameraScreen({
    Key? key,
    required this.cameras,
    required this.isReply,
    this.parent_video_id,
  }) : super(key: key);

  final List<CameraDescription>? cameras;
  bool isReply;
  int? parent_video_id;

  static Route route({required CameraScreenArgs args}) {
    return SlideRoute(
      page: CameraScreen(
        cameras: args.cameras,
        isReply: args.isReply,
        parent_video_id: args.parent_video_id,
      ),
    );
  }

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}


class _CameraScreenState extends State<CameraScreen> {
  CameraProvider? _cameraProvider;

  // Variables for Zoom Gesture
  double _initialVerticalDragDetails = 0.0;



  @override
  void initState() {
    super.initState();
    _cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    _cameraProvider?.initCamera(
      description: widget.cameras![1],
      mounted: mounted,
    );

    // // // Start recording automatically when the screen opens
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _cameraProvider?.startRecording();
    // });
  }

  @override
  void dispose() {
    _cameraProvider?.resetValues(isDisposing: true);
    super.dispose();
  }

  // Method to handle long press start
  // void _onLongPressStart() {
  //   if (!_isRecordingLocked) {
  //     _cameraProvider?.startRecording();
  //   }
  // }
  //
  // // Method to handle long press end
  // void _onLongPressEnd() {
  //   if (!_cameraProvider!.isRecordingLocked) {
  //     _cameraProvider?.stopRecording();
  //   }
  // }

  // Method to handle vertical drag update for zoom


  // Method to toggle recording lock

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        bool video = __.videoController == null;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: __.isCameraReady
              ? WillPopScope(
                onWillPop: () async{
                  _cameraProvider?.resetValues(isDisposing: true);

                  return true;
                },
                child: Column(
                            children: [
                Expanded(
                  child: Stack(
                    children: [
                      // GestureDetector for Long Press and Zoom
                      SizedBox(
                        height: cs.height(context),
                        width: cs.width(context),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: cs.width(context),
                            height: cs.width(context) * 16 / 9,
                            child: GestureDetector(
                              // onLongPressStart: (_) => _onLongPressStart(),
                              // onLongPressEnd: (details)=>_onLongPressEnd,
                              // onVerticalDragUpdate: _onVerticalDragUpdate,
                              child: video
                                  ? AspectRatio(
                                aspectRatio: 9 / 16, // Maintain aspect ratio
                                child: CameraPreview(
                                    __.cameraController),
                              )
                                  : VideoPlayer(
                                __.videoController!,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Countdown Timer
                      if (__.isVideoRecord)
                        Positioned(
                          bottom: 120, // Adjust position as needed
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              __.recordingDuration,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      // Lock Button

                      if(!__.recordingCompleted)
                      Positioned(
                        bottom: 80,
                        left: cs.width(context) * 0.3,
                        child: InkWell(
                          onTap: (){},
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 10),
                            color: __.isLockIconHovered?Colors.red: Colors.transparent,
                            child: Icon(
                              __.isRecordingLocked ?? false
                                  ? Icons.lock
                                  : Icons.lock_open,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      // Flip and Flash Buttons
                      if (__.isRecordStart && __.selectedVideo == null)
                        Positioned(
                          top: Platform.isIOS ? 85 : 60,
                          right: 20,
                          child: Column(
                            children: [
                              CameraBarItem(
                                iconColor: __.isCameraFlip
                                    ? Color(0xFFA858F4)
                                    : Colors.white,
                                label: 'Flip',
                                onTap: () {
                                  __.flipCamera(
                                    cameras: widget.cameras!,
                                  );
                                },
                                icon: AppAsset.icflip,
                              ),
                              SizedBox(height: 24),
                              CameraBarItem(
                                iconColor: __.isCameraFlashOn
                                    ? Color(0xFFA858F4)
                                    : Colors.white,
                                icon: __.isCameraFlashOn
                                    ? AppAsset.icflash2
                                    : AppAsset.icflash,
                                label: "Flash",
                                onTap: () {
                                  __.toggleFlash();
                                },
                              ),
                            ],
                          ),
                        ),
                      // Discard Button
                      if (!video)
                        Positioned(
                          top: Platform.isIOS ? 85 : 60,
                          right: 20,
                          child: CameraBarItem(
                            iconColor: Colors.white,
                            icon: AppAsset.icdiscard,
                            label: 'Discard',
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DiscardDialog(
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      // Back Button
                      Positioned(
                        top: Platform.isIOS ? 85 : 60,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            __.resetValues();
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Circular Button to Stop Recording and Navigate
                      if (!video)
                        Positioned(
                          bottom: 65,
                          width: cs.width(context),
                          child: CircularButton(
                            onTap: () async {
                              // Ensure recording is stopped before disposing
                              if (__.isVideoRecord) {
                                await __.stopRecording();
                              }

                              __.videoController?.pause();
                              __.cameraController.dispose();
                              Navigator.of(context)
                                  .pushNamed(
                                PostScreen.routeName,
                                arguments: PostScreenArgs(
                                  isReply: widget.isReply,
                                  path: __.selectedVideo,
                                  parent_video_id: widget.parent_video_id,
                                ),
                              )
                                  .then(
                                    (value) {
                                  __.resetValues();
                                  __.initCamera(
                                    description: widget.cameras![0],
                                    mounted: mounted,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                            ],
                          ),
              )
              : const Center(
            child: CustomProgressIndicator(),
          ),
        );
      },
    );
  }
}