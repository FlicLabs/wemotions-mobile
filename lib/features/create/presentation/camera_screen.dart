// ignore_for_file: must_be_immutable
import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

class CameraScreenArgs {
  bool isReply;
  int? parent_video_id;
  final List<CameraDescription>? cameras;
  CameraScreenArgs({this.cameras, required this.isReply, this.parent_video_id});
}

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera';

  CameraScreen(
      {Key? key,
      required this.cameras,
      required this.isReply,
      this.parent_video_id})
      : super(key: key);

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

  @override
  void initState() {
    super.initState();
    _cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    _cameraProvider?.initCamera(
      value: widget.cameras![0],
      mounted: mounted,
    );
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
                                )),
                        if (__.isRecordStart == true &&
                            __.selectedVideo == null)
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
                                    __.isCameraFlip = !__.isCameraFlip;
                                  },
                                  icon: AppAsset.icflip,
                                ),
                                height24,
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
                                    return DiscardDialog();
                                  },
                                );
                              },
                            ),
                          ),
                        // Positioned(
                        //   bottom: cs().height(context) * 0.25,
                        //   width: cs().width(context),
                        //   child: Text(
                        //     __.recordingDuration,
                        //     style: const TextStyle(
                        //       fontSize: 40,
                        //       color: Colors.white,
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                        Positioned(
                          top: Platform.isIOS ? 85 : 60,
                          left: 20,
                          child: GestureDetector(
                            onTap: () {
                              __.resetValues();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (!video)
                          Positioned(
                            bottom: 65,
                            width: cs().width(context),
                            child: CircularButton(
                              onTap: () {
                                __.videoController!.pause();
                                __.cameraController.dispose();
                                Navigator.of(context)
                                    .pushNamed(
                                  PostScreen.routeName,
                                  arguments: PostScreenArgs(
                                      isReply: widget.isReply,
                                      path: __.selectedVideo,
                                      parent_video_id: widget.parent_video_id),
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
