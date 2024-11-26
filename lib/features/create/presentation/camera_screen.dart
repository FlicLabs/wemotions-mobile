// ignore_for_file: must_be_immutable
import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

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
  double _currentZoom = 1.0;

  @override
  void initState() {
    super.initState();
    _cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    _cameraProvider?.initCamera(
      description: widget.cameras![1],
      mounted: mounted,
    );
  }

  @override
  void dispose() {
    _cameraProvider?.resetValues(isDisposing: true);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraProvider = Provider.of<CameraProvider>(context);
    _currentZoom = _cameraProvider?.currentZoomLevel ?? 1.0;
  }

  // Method to handle vertical drag update for zoom
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    double sensitivity = 0.005; // Adjust sensitivity as needed
    double delta = details.delta.dy * sensitivity;

    // Invert delta to make upward drag increase zoom
    double newZoom = _currentZoom - delta;

    // Clamp zoom level
    newZoom = newZoom.clamp(
      _cameraProvider!.minZoomLevel,
      _cameraProvider!.maxZoomLevel,
    );

    _currentZoom = newZoom;

    // Set the new zoom level via provider
    _cameraProvider!.setZoomLevel(_currentZoom);
  }

  // Method to handle double tap for camera flip
  void _onDoubleTap() {
    if (_cameraProvider!.isVideoRecord) {
      _cameraProvider!.flipCamera(cameras: widget.cameras!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        bool video = __.videoController == null;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: __.isCameraReady
              ? Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          // GestureDetector for Zoom and Double-Tap
                          SizedBox(
                            height: cs().height(context),
                            width: cs().width(context),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: cs().width(context),
                                height: cs().width(context) * 16 / 9,
                                child: video
                                    ? GestureDetector(
                                        onVerticalDragStart: (details) {
                                          _initialVerticalDragDetails =
                                              details.localPosition.dy;
                                        },
                                        onVerticalDragUpdate:
                                            _onVerticalDragUpdate,
                                        onDoubleTap: _onDoubleTap,
                                        child: CameraPreview(
                                            __.cameraController),
                                      )
                                    : VideoPlayer(
                                        __.videoController!,
                                      ),
                              ),
                            ),
                          ),
                          // Flip and Flash Buttons
                          if (__.isRecordStart &&
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
                                __.resetValues();
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
                              width: cs().width(context),
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
                          // Optional: Display Recording Duration
                          /*
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
                          */
                        ],
                      ),
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
