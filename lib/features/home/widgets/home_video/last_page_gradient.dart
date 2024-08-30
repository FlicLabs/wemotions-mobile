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
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
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
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
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
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: child,
                  ),
                ),
              ],
              height60,
              height20,
              Text('You have watched all videos',
                  style: AppTextStyle.normalBold18),
              height20,
              TransparentButton(
                onTap: () async {
                  final link = await search.dynamicLink.createSubverseLink(
                    imageUrl: home.posts[home.index].thumbnailUrl,
                    id: '${home.posts[home.index].id}',
                    title: '',
                    count: '',
                    description: '',
                    isSubverse: true,
                  );
                  Share.share(link);
                },
                title: 'Share',
              ),
              height10,
              TransparentButton(
                onTap: () async {
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
                            'Please allow access to camera to record videos',
                        tap: () {
                          openAppSettings();
                        },
                      ),
                    );
                  } else {
                    await availableCameras().then(
                      (value) => Navigator.of(context).pushNamed(
                        CameraScreen.routeName,
                        arguments: CameraScreenArgs(cameras: value),
                      ),
                    );
                  }
                },
                title: 'Post',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
