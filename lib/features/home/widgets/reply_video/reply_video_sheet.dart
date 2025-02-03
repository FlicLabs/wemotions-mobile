import 'package:socialverse/export.dart';

import '../home_video/action_sheet_item.dart';

class ReplyActionSheet extends StatelessWidget {
  const ReplyActionSheet({
    Key? key,
    required this.isUser,
    this.isCallback,
    this.isFromFeed,
    this.isFromSubverse,
    required this.current_index,
    required this.category_name,
    this.category_desc,
    required this.category_count,
    required this.category_id,
    required this.category_photo,
    this.isSubscribedRequired,
    required this.title,
    required this.video_link,
    this.isFromProfile,
    this.video_id,
  }) : super(key: key);

  final bool isUser;
  final bool? isCallback;
  final bool? isFromFeed;
  final bool? isFromSubverse;
  final int current_index;
  final String category_name;
  final String? category_desc;
  final int category_count;
  final int category_id;
  final String category_photo;
  final bool? isSubscribedRequired;
  final String title;
  final String video_link;
  final bool? isFromProfile;
  final int? video_id;

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    // final profile = Provider.of<ProfileProvider>(context);
    final notification = getIt<NotificationProvider>();
    bool isAdmin = isFromFeed == true ||
        isFromSubverse == true &&
            (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    print(
      'isAdmin: $isAdmin, isFromSubverse: $isFromSubverse, isFromProfile: $isFromProfile',
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: SizedBox(
        // height: 200,
        width: cs.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // if (isFromFeed == true) ...[
            //   ActionSheetItem(
            //     icon: Icons.speed,
            //     label: 'Set video Speed',
            //     onTap: () {
            //       HapticFeedback.mediumImpact();
            //       Navigator.pop(context);
            //       showModalBottomSheet(
            //         context: context,
            //         shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(30.0),
            //             topRight: Radius.circular(30.0),
            //           ),
            //         ),
            //         builder: (context) {
            //           return PlaybackSheet();
            //         },
            //       );
            //     },
            //   ),
            //   height20,
            // ],
            ActionSheetItem(
              svg: AppAsset.iccopy_link,
              label: 'Copy link',
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: video_link));
                Navigator.of(context).pop();
              },
            ),
            height20,
            ActionSheetItem(
              svg: AppAsset.directDownload,
              label: 'Download',
              onTap: () {
                HapticFeedback.mediumImpact();
                video.saveVideo(
                  videoUrl: video_link,
                  title: title,
                );
                Navigator.of(context).pop();
              },
            ),
            height20,
            // if (isUser == true && isFromFeed == true) height20,
            if (isUser == true && isFromFeed == true) ...[
              ActionSheetItem(
                svg: AppAsset.icReport,
                label: 'Report',
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  int index = current_index + 1;
                  Navigator.pop(context);
                  home.createIsolate(token: token);
                  home.animateToPage(index);
                  await home.removeController(current_index);
                  List<List<Posts>> post_list = home.posts;
                  post_list.removeAt(current_index);
                  home.posts = post_list;
                  notification.show(
                    title: 'Post has been reported',
                    type: NotificationType.local,
                  );
                },
              ),
              height20,
            ],

            // Profile
            // if (isFromProfile == true) ...[
            //   ActionSheetItem(
            //     icon: Icons.delete_outline,
            //     label: 'Delete',
            //     onTap: () async {
            //       HapticFeedback.mediumImpact();
            //       final response = await home.deletePost(id: video_id!);
            //       if (response == 200 || response == 201) {
            //         List<Posts> post_list = profile.posts;
            //         post_list.removeAt(current_index);
            //         profile.posts = post_list;
            //         profile.fetchProfile(username: prefs_username!);
            //         Navigator.of(context, rootNavigator: true)
            //           ..pop()
            //           ..pop();
            //         notification.show(
            //           title: 'Post has been deleted',
            //           type: NotificationType.local,
            //         );
            //       } else {
            //         Navigator.pop(context);
            //         notification.show(
            //           title: 'Something went wrong',
            //           type: NotificationType.local,
            //         );
            //       }
            //     },
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}
