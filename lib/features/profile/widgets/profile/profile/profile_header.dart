import 'package:socialverse/export.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

            },
            child: Icon(
              UniconsLine.link_alt,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          width20,
          GestureDetector(
            onTap: () async {
              // PermissionStatus status = await Permission.camera.request();
              // if (status.isDenied || status.isPermanentlyDenied) {
              //   showDialog(
              //     context: context,
              //     builder: (context) => CustomAlertDialog(
              //       title: 'Permission Denied',
              //       action: 'Open Settings',
              //       content: 'Please allow access to camera to record videos',
              //       tap: () {
              //         openAppSettings();
              //       },
              //     ),
              //   );
              // } else {
              //   PermissionStatus status = await Permission.camera.request();
              //   if (status.isDenied || status.isPermanentlyDenied) {
              //     showDialog(
              //       context: context,
              //       builder: (context) => CustomAlertDialog(
              //         title: 'Permission Denied',
              //         action: 'Open Settings',
              //         content: 'Please allow access to camera to record videos',
              //         tap: () {
              //           openAppSettings();
              //         },
              //       ),
              //     );
              //   } else {
              //     await availableCameras().then(
              //       (value) => Navigator.of(context).pushNamed(
              //         CameraScreen.routeName,
              //         arguments: CameraScreenArgs(cameras: value,isReply: false),
              //       ),
              //     );
              //   }
              // }
            },
            child: SvgPicture.asset(
              AppAsset.icadd,
              height: 22,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          width20,
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                SettingsScreen.routeName,
              );
            },
            child: SvgPicture.asset(
              AppAsset.icsetting,
              height: 22,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ],
      ),
    );
  }
}
