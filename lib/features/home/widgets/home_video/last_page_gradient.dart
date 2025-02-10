import 'package:socialverse/export.dart';

class LastPageGradient extends StatelessWidget {
  const LastPageGradient({
    super.key,
    required this.isInit,
    required this.child,
    required this.childImage,
  });

  final bool isInit;
  final Widget child;
  final String childImage;

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final camera = Provider.of<CameraProvider>(context);
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.purple.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isInit) ...[
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: isInit?ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: child,
                  ): ClipRRect(child: Image.network(childImage,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(20),),
                ),
              ],
              height60,
              height20,
              Text('You have watched all videos',
                  style: AppTextStyle.normalBold18),
              height20,
              TransparentButton(
                onTap: () async {
                  Share.share('link');
                },
                title: 'Share',
                textColor: Constants.darkPrimary,
                color: Constants.lightPrimary,
              ),
              height10,
              TransparentButton(
                onTap: () async {
                  // if (home.videoController(home.index)!.value.isPlaying) {
                  //   await home.videoController(home.index)!.pause();
                  // }
                  PermissionStatus status = await Permission.camera.request();
                  if (status.isDenied || status.isPermanentlyDenied) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Permission Denied',
                        action: 'Open Settings',
                        content:
                            'Please allow access to camera to record videos',
                        tap: () {
                          openAppSettings();
                        },
                      ),
                    );
                  } else {
                    print('IM IN');
                    // camera.showCameraScreen=true;
                    await availableCameras().then(
                      (value) {

                        camera.shouldStartRecording = true;
                        camera.localValue=value;
                        camera.isReply=false;
                        camera.showCameraScreen = true;
                        camera.isLongPressed=false;


                        // Navigator.of(context).pushNamed(
                        // CameraScreen.routeName,
                        // arguments: CameraScreenArgs(cameras: value,isReply: false),
                        // );
                      }
                    );
                  }
                },
                title: 'Post',
                textColor: Constants.darkPrimary,
                color: Constants.lightPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
