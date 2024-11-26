// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

class InstantCameraScreenArgs {
  bool isReply;
  int? parent_video_id;
  final List<CameraDescription>? cameras;
  InstantCameraScreenArgs(
      {this.cameras, required this.isReply, this.parent_video_id});
}

class InstantCameraScreen extends StatefulWidget {
  static const String routeName = '/instant-camera';

  InstantCameraScreen(
      {Key? key,
      required this.cameras,
      required this.isReply,
      this.parent_video_id})
      : super(key: key);

  final List<CameraDescription>? cameras;
  bool isReply;
  int? parent_video_id;

  static Route route({required InstantCameraScreenArgs args}) {
    return SlideRoute(
      page: InstantCameraScreen(
        cameras: args.cameras,
        isReply: args.isReply,
        parent_video_id: args.parent_video_id,
      ),
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
      value: widget.cameras![0],
      mounted: mounted,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startVideoRecordingInit();
    });
  }

  void startVideoRecordingInit() async {
    if (_cameraProvider != null) {
      _cameraProvider!.shouldStartRecording = true;
      _cameraProvider!.showCameraScreen = true;
      log('DEBUG: InstantCameraScreen started recording');
    }
  }

  @override
  void dispose() {
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
      builder: (_, cameraProvider, __) {
        bool isVideo = cameraProvider.videoController == null;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: cameraProvider.cameraController.value.isInitialized
              ? Column(
                  children: [
                    Stack(
                      children: [
                        isVideo
                            ? SizedBox(
                                height: cs().height(context),
                                width: cs().width(context),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: cs().width(context),
                                    height: cs().width(context) * 16 / 9,
                                    child: CameraPreview(
                                        cameraProvider.cameraController),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (cameraProvider
                                      .videoController!.value.isPlaying) {
                                    cameraProvider.videoController!.pause();
                                  } else {
                                    cameraProvider.videoController!.play();
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
                                      child: VideoPlayer(
                                          cameraProvider.videoController!),
                                    ),
                                  ),
                                ),
                              ),
                        if (cameraProvider.isRecordStart &&
                            cameraProvider.selectedVideo == null)
                          Positioned(
                            top: Platform.isIOS ? 50 : 60,
                            right: 20,
                            child: Column(
                              children: [
                                CameraBarItem(
                                  iconColor: cameraProvider.isCameraFlip
                                      ? Color(0xFFA858F4)
                                      : Colors.white,
                                  label: 'Flip',
                                  onTap: () {
                                    cameraProvider.flipCamera(
                                      cameras: widget.cameras!,
                                    );
                                    cameraProvider.isCameraFlip =
                                        !cameraProvider.isCameraFlip;
                                  },
                                  icon: AppAsset.icflip,
                                ),
                                SizedBox(height: 24),
                                CameraBarItem(
                                  iconColor: cameraProvider.isCameraFlashOn
                                      ? Color(0xFFA858F4)
                                      : Colors.white,
                                  icon: cameraProvider.isCameraFlashOn
                                      ? AppAsset.icflash2
                                      : AppAsset.icflash,
                                  label: "Flash",
                                  onTap: () {
                                    cameraProvider.toggleFlash();
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (!isVideo)
                          Positioned(
                            top: Platform.isIOS ? 50 : 60,
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
                          bottom: cs().height(context) * 0.25,
                          width: cs().width(context),
                          child: Text(
                            cameraProvider.recordingDuration,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Positioned(
                          top: Platform.isIOS ? 50 : 60,
                          left: 20,
                          child: GestureDetector(
                            onTap: () {
                              cameraProvider.resetValues();
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (!isVideo)
                          Positioned(
                            bottom: cs().height(context) * 0.09,
                            width: cs().width(context),
                            child: CircularButton(
                              onTap: () {
                                cameraProvider.videoController!.pause();
                                cameraProvider.cameraController.dispose();
                                Navigator.of(context)
                                    .pushNamed(
                                  PostScreen.routeName,
                                  arguments: PostScreenArgs(
                                      isReply: widget.isReply,
                                      path: cameraProvider.selectedVideo,
                                      parent_video_id: widget.parent_video_id),
                                )
                                    .then(
                                  (value) {
                                    cameraProvider.resetValues();
                                    cameraProvider.initCamera(
                                      value: widget.cameras![0],
                                      mounted: mounted,
                                    );
                                  },
                                );
                              },
                            ),
                          )
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
