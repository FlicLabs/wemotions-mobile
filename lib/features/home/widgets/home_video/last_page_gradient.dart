import 'package:socialverse/export.dart';

class LastPageGradient extends StatelessWidget {
  const LastPageGradient({
    super.key,
    required this.isInit,
    required this.child,
  });

  final bool isInit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final search = Provider.of<SearchProvider>(context);
    final size = MediaQuery.of(context).size;

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.9),
              Colors.black,
              Colors.purple.withOpacity(0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isInit) ...[
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.2,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: child,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 40),

              // Finished Watching Text
              Text(
                'You have watched all videos',
                style: AppTextStyle.normalBold18.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Share Button
              ElevatedButton(
                onPressed: () async {
                  Share.share('link');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Share',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),

              // Post Button
              ElevatedButton(
                onPressed: () async {
                  if (home.videoController(home.index)!.value.isPlaying) {
                    await home.videoController(home.index)!.pause();
                  }
                  PermissionStatus status = await Permission.camera.request();
                  if (status.isDenied || status.isPermanentlyDenied) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Permission Denied',
                        action: 'Open Settings',
                        content:
                            'Please allow access to the camera to record videos',
                        tap: () {
                          openAppSettings();
                        },
                      ),
                    );
                  } else {
                    await availableCameras().then(
                      (value) => Navigator.of(context).pushNamed(
                        CameraScreen.routeName,
                        arguments: CameraScreenArgs(
                          cameras: value,
                          isReply: false,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

