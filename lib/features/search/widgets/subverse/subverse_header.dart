import 'package:socialverse/export.dart';

class SubverseHeader extends StatelessWidget {
  const SubverseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatProvider>(context);
    // final subverse = Provider.of<SearchProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              PermissionStatus status = await Permission.camera.request();
              if (status.isDenied || status.isPermanentlyDenied) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Permission Denied',
                    action: 'Open Settings',
                    content: 'Please allow access to camera to record videos',
                    tap: () {
                      openAppSettings();
                    },
                  ),
                );
              } else {
                PermissionStatus status = await Permission.camera.request();
                if (status.isDenied || status.isPermanentlyDenied) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Permission Denied',
                      action: 'Open Settings',
                      content: 'Please allow access to camera to record videos',
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
              }
            },
            child: SvgPicture.asset(
              AppAsset.icadd,
              height: 22,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          width10,
          GestureDetector(
            onTap: () async {
              if (logged_in!) {
                if (gc_member!) {
                  Navigator.pushNamed(context, ChatScreen.routeName);
                } else {
                  await chat.joinGroupChat();
                  Navigator.pushNamed(context, ChatScreen.routeName);
                }
              } else {
                auth.showAuthBottomSheet(context);
              }
            },
            child: SvgPicture.asset(
              AppAsset.chat,
              height: 25,
              width: 25,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          // width10,
          // GestureDetector(
          //   onTap: () async {
          //     await HapticFeedback.mediumImpact();
          //     final link = await subverse.dynamicLink.createSubverseLink(
          //       imageUrl: subverse.subverse_info.imageUrl,
          //       id: '${subverse.subverse_info.id}',
          //       title: subverse.subverse_info.name,
          //       count: '${subverse.subverse_info.count}',
          //       description: subverse.subverse_info.description,
          //       isSubverse: true,
          //     );
          //     showModalBottomSheet(
          //       context: context,
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(30.0),
          //           topRight: Radius.circular(30.0),
          //         ),
          //       ),
          //       builder: (context) {
          //         return SubverseShareSheet(dynamicLink: link);
          //       },
          //     );
          //   },
          //   child: Icon(
          //     UniconsLine.share,
          //     color: Theme.of(context).indicatorColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}
