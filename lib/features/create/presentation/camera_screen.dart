// ignore_for_file: must_be_immutable
import 'package:socialverse/export.dart';
import 'package:socialverse/features/create/utils/discard_dialog.dart';

class CameraScreenArgs {
  final bool isReply;
  final int? parentVideoId;
  final List<CameraDescription>? cameras;

  CameraScreenArgs({
    required this.isReply,
    this.parentVideoId,
    this.cameras,
  });
}

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera';

  const CameraScreen({
    Key? key,
    required this.cameras,
    required this.isReply,
    this.parentVideoId,
  }) : super(key: key);

  final List<CameraDescription>? cameras;
  final bool isReply;
  final int? parentVideoId;

  static Route route({required CameraScreenArgs args}) {
    return SlideRoute(
      page: CameraScreen(
        cameras: args.cameras,
        isReply: args.isReply,
        parentVideoId: args.parentVideoId,
      ),
    );
  }

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final CameraProvider _cameraProvider;
  double _currentZoom = 1.0;

  @override
  void initState() {
    super.initState();
    _cameraProvider = Provider.of<CameraProvider>(context, listen: false);
    if (widget.cameras?.isNotEmpty ?? false) {
      _cameraProvider.initCamera(
        description: widget.cameras![1],
        mounted: mounted,
      );
    }
  }

  @override
  void dispose() {
    _cameraProvider.resetValues(isDisposing: true);
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    const double sensitivity = 0.005;
    final double newZoom = (_currentZoom - details.delta.dy * sensitivity)
        .clamp(_cameraProvider.minZoomLevel, _cameraProvider.maxZoomLevel);

    if (newZoom != _currentZoom) {
      _currentZoom = newZoom;
      _cameraProvider.setZoomLevel(_currentZoom);
    }
  }

  void _onDoubleTap() {
    if (_cameraProvider.isVideoRecord) {
      _cameraProvider.flipCamera(cameras: widget.cameras!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Consumer<CameraProvider>(
        builder: (context, provider, child) {
          final bool isVideoMode = provider.videoController == null;

          return provider.isCameraReady
              ? Stack(
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: _onVerticalDragUpdate,
                      onDoubleTap: _onDoubleTap,
                      child: SizedBox(
                        height: cs().height(context),
                        width: cs().width(context),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: cs().width(context),
                            height: cs().width(context) * 16 / 9,
                            child: isVideoMode
                                ? Transform.scale(
                                    scale: 1.35,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                          CameraPreview(provider.cameraController),
                                    ),
                                  )
                                : VideoPlayer(provider.videoController!),
                          ),
                        ),
                      ),
                    ),
                    if (provider.isRecordStart && provider.selectedVideo == null)
                      Positioned(
                        top: Platform.isIOS ? 85 : 60,
                        right: 20,
                        child: Column(
                          children: [
                            CameraBarItem(
                              iconColor: provider.isCameraFlip
                                  ? const Color(0xFFA858F4)
                                  : Colors.white,
                              label: 'Flip',
                              onTap: () => provider.flipCamera(
                                cameras: widget.cameras!,
                              ),
                              icon: AppAsset.icflip,
                            ),
                            const SizedBox(height: 24),
                            CameraBarItem(
                              iconColor: provider.isCameraFlashOn
                                  ? const Color(0xFFA858F4)
                                  : Colors.white,
                              icon: provider.isCameraFlashOn
                                  ? AppAsset.icflash2
                                  : AppAsset.icflash,
                              label: "Flash",
                              onTap: provider.toggleFlash,
                            ),
                          ],
                        ),
                      ),
                    if (!isVideoMode)
                      Positioned(
                        top: Platform.isIOS ? 85 : 60,
                        right: 20,
                        child: CameraBarItem(
                          iconColor: Colors.white,
                          icon: AppAsset.icdiscard,
                          label: 'Discard',
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => const DiscardDialog(),
                          ),
                        ),
                      ),
                    Positioned(
                      top: Platform.isIOS ? 85 : 60,
                      left: 20,
                      child: GestureDetector(
                        onTap: provider.resetValues,
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    if (!isVideoMode)
                      Positioned(
                        bottom: 65,
                        width: cs().width(context),
                        child: CircularButton(
                          onTap: () async {
                            if (provider.isVideoRecord) {
                              await provider.stopRecording();
                            }

                            provider.videoController?.pause();
                            provider.cameraController.dispose();

                            Navigator.of(context)
                                .pushNamed(
                                  PostScreen.routeName,
                                  arguments: PostScreenArgs(
                                    isReply: widget.isReply,
                                    path: provider.selectedVideo,
                                    parentVideoId: widget.parentVideoId,
                                  ),
                                )
                                .then((_) {
                                  provider.resetValues();
                                  provider.initCamera(
                                    description: widget.cameras![0],
                                    mounted: mounted,
                                  );
                                });
                          },
                        ),
                      ),
                  ],
                )
              : const Center(child: CustomProgressIndicator());
        },
      ),
    );
  }
}
