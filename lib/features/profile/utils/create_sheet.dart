import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/utils/create_sheet_item.dart';

class CreateSheet extends StatelessWidget {
  const CreateSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CreateSheetItem(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(
          //       CreateSubverseScreen.routeName,
          //     );
          //   },
          //   label: 'Subverse',
          //   asset: AppAsset.vible,
          // ),
          // height20,
          CreateSheetItem(
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
                      arguments: CameraScreenArgs(cameras: value,isReply: false),
                    ),
                  );
                }
              }
            },
            label: 'Post',
            asset: AppAsset.icposts,
          ),
          height40,
        ],
      ),
    );
  }
}
