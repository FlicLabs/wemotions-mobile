import 'package:socialverse/export.dart';

class CameraScreenArgs {
  bool isReply;
  String? parent_video_id;
  final List<CameraDescription>? cameras;
  CameraScreenArgs({this.cameras,required this.isReply,this.parent_video_id});
}

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera';

  CameraScreen({Key? key, required this.cameras, required this.isReply, this.parent_video_id}) : super(key: key);

  final List<CameraDescription>? cameras;
  bool isReply;
  String? parent_video_id;

  static Route route({required CameraScreenArgs args}) {
    return SlideRoute(
      page: CameraScreen(cameras: args.cameras,isReply: args.isReply,parent_video_id: args.parent_video_id,),
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
          backgroundColor: Colors.black,
          body: __.cameraController.value.isInitialized
              ? Column(
                  children: [
                    Stack(
                      children: [
                        video
                            ? Container(
                                height: video
                                    ? cs().height(context) / 1.2
                                    : cs().height(context),
                                width: cs().width(context),
                                child: GestureDetector(
                                  onVerticalDragStart: (drag) {
                                    __.imagePicker(context);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
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
                                child: Container(
                                  height: cs().height(context),
                                  width: cs().width(context),
                                  child: Center(
                                    child: AspectRatio(
                                      aspectRatio:
                                          __.videoController!.value.aspectRatio,
                                      child: VideoPlayer(
                                        __.videoController!,
                                      ),
                                    ),
                                  ),
                                ),
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
                            top: Platform.isIOS ? 45 : 50,
                            right: 10,
                            child: Column(
                              children: [
                                CameraBarItem(
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
                                height10,
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.10),
                                  ),
                                  child: PopupMenuButton<int>(
                                    color: Colors.white,
                                    icon: SvgPicture.asset(
                                      AppAsset.icspeed,
                                      height: 25,
                                    ),
                                    onSelected: (value) async {
                                      if (value == 1) {
                                        __.video_speed = 0.5;
                                      }
                                      if (value == 2) {
                                        __.video_speed = 1.0;
                                      }
                                      if (value == 3) {
                                        __.video_speed = 10.0;
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text(
                                          "0.5",
                                          style: AppTextStyle.normalBold14
                                              .copyWith(color: Colors.black),
                                        ),
                                        value: 1,
                                        height: 30,
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem(
                                        child: Text(
                                          "1",
                                          style: AppTextStyle.normalBold14
                                              .copyWith(color: Colors.black),
                                        ),
                                        height: 30,
                                        value: 2,
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem(
                                        child: Text(
                                          "10",
                                          style: AppTextStyle.normalBold14
                                              .copyWith(color: Colors.black),
                                        ),
                                        height: 30,
                                        value: 3,
                                      ),
                                    ],
                                  ),
                                ),
                                height5,
                                Text(
                                  "Speed",
                                  style: AppTextStyle.normalBold14
                                      .copyWith(color: Colors.white),
                                ),
                                height10,
                                CameraBarItem(
                                  icon: AppAsset.ictimer,
                                  label: 'Timer',
                                  onTap: () {
                                    __.is_timer_on = !__.is_timer_on;
                                  },
                                ),
                                height10,
                                CameraBarItem(
                                  icon: __.is_camera_flash_on == false
                                      ? AppAsset.icflash
                                      : AppAsset.icflash2,
                                  label: "Flash",
                                  onTap: () {
                                    __.toggleFlash();
                                    // __.is_camera_flash_on =
                                    //     !__.is_camera_flash_on;
                                  },
                                ),
                              ],
                            ),
                          ),
                        Positioned(
                          bottom: cs().height(context) * 0.08,
                          width: cs().width(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              video
                                  ? RecordButton()
                                  : CircularButton(
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
                                    )
                            ],
                          ),
                        ),
                        if (__.is_timer_count == true)
                          Positioned(
                            bottom: cs().height(context) * 0.25,
                            width: cs().width(context),
                            child: Text(
                              __.timer_value != 3
                                  ? (3 - __.timer_value).toString()
                                  : "",
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          child: AppBar(
                            backgroundColor: Colors.transparent,
                            iconTheme: IconThemeData(color: Colors.white),
                            actions: [
                              // comment.comment.clear();
                              // comment.focusNode.unfocus();
                            ],
                          ),
                        )
                      ],
                    ),
                    if (video) height20,
                    if (video) CustomImagePicker()
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
