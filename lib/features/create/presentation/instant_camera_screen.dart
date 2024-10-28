import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

class InstantCameraScreenArgs {
  bool isReply;
  String? parent_video_id;
  final List<CameraDescription>? cameras;
  InstantCameraScreenArgs({this.cameras,required this.isReply,this.parent_video_id});
}

class InstantCameraScreen extends StatefulWidget {
  static const String routeName = '/instantcamera';

  InstantCameraScreen({Key? key, required this.cameras, required this.isReply, this.parent_video_id}) : super(key: key);

  final List<CameraDescription>? cameras;
  bool isReply;
  String? parent_video_id;

  static Route route({required InstantCameraScreenArgs args}) {
    return SlideRoute(
      page: InstantCameraScreen(cameras: args.cameras,isReply: args.isReply,parent_video_id: args.parent_video_id,),
    );
  }

  @override
  State<InstantCameraScreen> createState() => _InstantCameraScreenState();
}

class _InstantCameraScreenState extends State<InstantCameraScreen> {
  CameraProvider? _cameraProvider;
  @override
  void initState() {
    super.initState();
    _cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    _cameraProvider?.initCamera(
      value: widget.cameras![1],
      mounted: mounted,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startVideoRecordingInit(_cameraProvider);
    });
  }

  void startVideoRecordingInit(_cameraProvider) async{
    _cameraProvider.is_timer_on = true;
    if (_cameraProvider.is_timer_on) {
      _cameraProvider.selectedTimerDuration = 3;
    }
    if (_cameraProvider.is_timer_on == true) {
      if (_cameraProvider.is_first_click == false) {
        _cameraProvider.is_record_start = !_cameraProvider.is_record_start;
        _cameraProvider.is_timer_count = !_cameraProvider.is_timer_count;
        _cameraProvider.is_video_record = !_cameraProvider.is_video_record;
        _cameraProvider.startTimerButton();
        _cameraProvider.is_first_click = !_cameraProvider.is_first_click;
      } else {
        _cameraProvider.is_video_pause = !_cameraProvider.is_video_pause;
        _cameraProvider.is_video_record = !_cameraProvider.is_video_record;
        _cameraProvider.is_timer_selected = true;
        if (_cameraProvider.is_camera_flash_on == true) {
          _cameraProvider.cameraController.setFlashMode(
            FlashMode.off,
          );
        }
        _cameraProvider.selectedVideo =
        await _cameraProvider.cameraController.stopVideoRecording();
        _cameraProvider.initVideo();
        _cameraProvider.stopRecordingTimer();
        _cameraProvider.cameraController.buildPreview();
      }
    }
  }

  @override
  void dispose() {
    _cameraProvider?.cameraController.dispose();
    _cameraProvider?.resetValues();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraProvider = Provider.of<CameraProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        bool video = __.videoController == null;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: __.cameraController.value.isInitialized
              ? Column(
                  children: [
                    Stack(
                      children: [
                        video
                            ? SizedBox(
                          height: cs().height(context),
                          width: cs().width(context),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: cs().width(context),
                              height: cs().width(context) * 16 / 9,
                              child: CameraPreview(__.cameraController),
                            ),
                          ),
                        )
                            : GestureDetector(
                                onTap: () {
                                  if (__.videoController!.value.isPlaying) {
                                    __.videoController!.pause();
                                  } else {
                                    __.videoController!.play();
                                  }
                                },
                                child: SizedBox(
                                  height: cs().height(context),
                                  width: cs().width(context),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: cs().width(context),
                                      height: cs().width(context) * 16 / 9,
                                      child: VideoPlayer(__.videoController!),
                                    ),
                                  ),
                                )
                              ),
                        // if (__.is_video_record == false)
                        //   Positioned(
                        //     top: Platform.isAndroid ? 5 : 0,
                        //     left: 15,
                        //     child: SafeArea(
                        //       child: CustomIconButton(
                        //         icon: Icons.arrow_back_ios_new_rounded,
                        //         borderRadius: 12,
                        //         onTap: () {
                        //           log('tap');
                        //           if (__.selectedVideo?.path.isEmpty ?? true) {
                        //             __.resetValues();
                        //             Navigator.pop(context);
                        //           } else {
                        //             __.videoController!.dispose();
                        //             __.resetValues();
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        if (__.is_record_start == true &&
                            __.selectedVideo == null)
                          Positioned(
                            top: Platform.isIOS ? 85 : 90,
                            right: 20,
                            child: Column(
                              children: [
                                CameraBarItem(
                                  iconColor: __.is_camera_flip ?  Color(0xFFA858F4) : Colors.white,
                                  label: 'Flip',
                                  onTap: () {
                                    // __.cameraController = CameraController(
                                    //   widget
                                    //       .cameras![__.is_camera_flip ? 1 : 0],
                                    //   ResolutionPreset.max,
                                    // );
                                    // __.cameraController.initialize().then(
                                    //   (_) {
                                    //     if (!mounted) return;
                                    //   },
                                    // );
                                    __.flipCamera(
                                      cameras: widget.cameras!,
                                    );
                                    __.is_camera_flip = !__.is_camera_flip;
                                  },
                                  icon: AppAsset.icflip,
                                ),
                              ],
                            ),
                          ),
                        if (!video)
                          Positioned(
                            top: Platform.isIOS ? 85 : 90,
                            right: 20,
                            child: CameraBarItem(
                              iconColor: Colors.white,
                              icon: AppAsset.icdiscard,
                              label: 'Discard',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DiscardDialog();
                                  },
                                );
                              },
                            ),
                          ),
                        Positioned(
                          bottom: cs().height(context) * 0.08,
                          width: cs().width(context),
                          child: Column(
                            children: [
                              if (video)
                                Container(
                                  child: Text(__.recordingDuration,style: TextStyle(color: Colors.white, fontSize: 20),),
                                ),
                                height8,

                             RecordButton()
                            ],
                          ),
                        ),
                        if (__.is_timer_count == true)
                          Positioned(
                            bottom: cs().height(context) * 0.25,
                            width: cs().width(context),
                            child: Text(
                              __.timer_value != __.selectedTimerDuration
                                  ? (__.selectedTimerDuration - __.timer_value).toString()
                                  : "",
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Positioned(
                          top: Platform.isIOS ? 85 : 90,
                          left: 20,
                          child: GestureDetector(
                            onTap: (){
                              __.resetValues();
                              Navigator.pop(context);
                            },
                            child: Icon(
                                Icons.arrow_back,
                              color: Colors.white,
                            ),
                          )
                        ),
                        // if (video) Positioned(bottom: cs().height(context) * 0.08,
                        //     width: cs().width(context),child: CustomImagePicker()),

                        if (!video) Positioned(bottom: cs().height(context) * 0.09,
                            width: cs().width(context),child: CircularButton(
                              onTap: () {
                                __.videoController!.pause();
                                __.cameraController.dispose();
                                Navigator.of(context)
                                    .pushNamed(
                                  PostScreen.routeName,
                                  arguments: PostScreenArgs(
                                      isReply: widget.isReply,
                                      path: __.selectedVideo,
                                      parent_video_id: widget.parent_video_id
                                  ),
                                )
                                    .then(
                                      (value) {
                                    __.resetValues();
                                    __.initCamera(
                                      value: widget.cameras![0],
                                      mounted: mounted,
                                    );
                                  },
                                );
                              },
                            ))
                      ],
                    ),
                  ],
                )
              : const Center(
                  child: CustomProgressIndicator(),
                ),
        );
      },
    );
  }
}
