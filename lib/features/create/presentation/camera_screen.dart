// ignore_for_file: must_be_immutable
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

import '../../../core/configs/page_routers/slide_route.dart';
import '../utils/circular_clipper.dart';
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
  late CameraProvider _cameraProvider;

  // Variables for Zoom Gesture
  double _initialVerticalDragDetails = 0.0;

  @override
  void initState() {
    super.initState();
    _cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    _cameraProvider.initCamera(
      description: widget.cameras![1],
      mounted: mounted,
    );
  }

  @override
  void dispose() {
    _cameraProvider.resetValues(isDisposing: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Consumer<CameraProvider>(
                builder: (_, __, ___) {
                  bool video = __.videoController == null;

                  return Stack(
                    children: [
                      if (__.isCameraReady &&
                          __.cameraController != null &&
                          !__.isAnythingNull) ...[
                        SizedBox(
                          height: cs.height(context),
                          width: cs.width(context),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: cs.width(context),
                              height: cs.width(context) * 16 / 9,
                              child: GestureDetector(
                                child: video
                                    ? AspectRatio(
                                        aspectRatio:
                                            9 / 16, // Maintain aspect ratio
                                        child:
                                            CameraPreview(__.cameraController!),
                                      )
                                    : VideoPlayer(
                                        __.videoController!,
                                      ),
                              ),
                            ),
                          ),
                        ),

                        if (!__.isRearCamera && __.isCameraFlashOn)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  20),
                              child: Stack(
                                children: [
                                  ClipPath(
                                    clipper: CircularClipper(),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10,
                                          sigmaY: 10), // Blurred edges effect
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white.withOpacity(0.7),
                                          gradient: RadialGradient(
                                            colors: [
                                              Colors.white70,
                                              Colors.white60,
                                              Colors.white54,
                                              Colors.white38,
                                              Colors.white30,
                                              Colors.white,
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              blurRadius: 20,
                                              spreadRadius: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ClipPath(
                                    clipper: SmallerCircularClipper(),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 11,
                                          sigmaY: 11), // More blur on smaller cutout
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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

                        if (!__.recordingCompleted && !__.isThroughSingleTap)
                          Positioned(
                            bottom: 80,
                            left: cs.width(context) * 0.3,
                            child: InkWell(
                              onTap: () {},
                              child: Stack(
                                children: [
                                  if (!__.isRecordingLocked)
                                    AnimatedPositioned(
                                      duration: Duration(milliseconds: 250),
                                      left: __.isLockIconHovered ? -5 : 10,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        height: __.isLockIconHovered ? 40 : 50,
                                        width: __.isRecordingLocked ? 40 : 50,
                                        decoration: BoxDecoration(
                                          color: __.isLockIconHovered
                                              ? Colors.grey
                                              : Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      __.isRecordingLocked ?? false
                                          ? Icons.lock
                                          : Icons.lock_open,
                                      color: __.isLockIconHovered
                                          ? Colors.black
                                          : Colors.white,
                                      size: 30,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
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
                                      ? AppAsset.icflash
                                  : AppAsset.icflash2,
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
                                    return DiscardDialog();
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
                              HapticFeedback.mediumImpact();
                              __.resetValues(isDisposing: true);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Constants.lightPrimary,
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
                                if (__.isVideoRecord) {
                                  await __.stopRecording();
                                }

                                __.videoController?.pause();

                                // if(__.cameraController!=null){
                                //   __.cameraController!.dispose();
                                // }

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
                                    // __.resetValues(isDisposing: true);
                                    // __.initCamera(
                                    //   description: widget.cameras![0],
                                    //   mounted: mounted,
                                    // );
                                  },
                                );
                              },
                            ),
                          ),
                      ] else
                        const Center(
                          child: CustomProgressIndicator(),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
