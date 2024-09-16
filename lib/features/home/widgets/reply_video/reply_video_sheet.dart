import 'package:socialverse/export.dart';


class ReplyVideoSheet extends StatelessWidget {
  const ReplyVideoSheet({
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
    final reply = Provider.of<ReplyProvider>(context);
    final subverse = Provider.of<SearchProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    final notification = getIt<NotificationProvider>();
    bool isAdmin = isFromFeed == true ||
        isFromSubverse == true &&
            (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    print(
      'isAdmin: $isAdmin, isFromSubverse: $isFromSubverse, isFromProfile: $isFromProfile',
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: SizedBox(
        height: 100,
        width: cs().width(context),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isUser == true && isFromSubverse == true) width20,
                if (isUser == true && isFromSubverse == true) ...[
                  VideoSheetItem(
                    icon: Icons.flag_outlined,
                    label: 'Report',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      int index = current_index + 1;
                      Navigator.pop(context);
                      // home.createIsolate(token: token);
                      reply.animateToPage(index);
                      await reply.removeController(current_index);
                      List<Posts> post_list = home.posts[home.index];
                      post_list.removeAt(current_index+1);
                      home.posts[home.index] = post_list;
                      reply.posts = home.posts[home.index].sublist(1);
                      notification.show(
                        title: 'Post has been reported',
                        type: NotificationType.local,
                      );
                    },
                  ),
                ],

                if (isUser == true && isFromFeed == true) width20,
                if (isUser == true && isFromFeed == true) ...[
                  VideoSheetItem(
                    icon: Icons.flag_outlined,
                    label: 'Report',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      int index = current_index + 1;
                      Navigator.pop(context);
                      // home.createIsolate(token: token);
                      reply.animateToPage(index);
                      await reply.removeController(current_index);
                      List<Posts> post_list = home.posts[home.index];
                      post_list.removeAt(current_index + 1);
                      home.posts[home.index] = post_list;
                      reply.posts = home.posts[home.index].sublist(1);
                      notification.show(
                        title: 'Post has been reported',
                        type: NotificationType.local,
                      );
                    },
                  ),
                ],
                if (isUser == true && isFromFeed == true) width20,
                if (isUser == true && isFromFeed == true) ...[
                  VideoSheetItem(
                    icon: Icons.heart_broken_outlined,
                    label: 'Not Vibing',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      await home.blockPost(id: video_id!);
                      int index = current_index + 1;
                      Navigator.pop(context);
                      // home.createIsolate(token: token);
                      reply.animateToPage(index);
                      await reply.removeController(current_index);
                      List<Posts> post_list = home.posts[home.index];
                      post_list.removeAt(current_index + 1);
                      home.posts[home.index] = post_list;
                      reply.posts = home.posts[home.index].sublist(1);
                      notification.show(
                        title: 'We will show you fewer videos like this',
                        type: NotificationType.local,
                      );
                    },
                  ),
                ],
                width20,
                VideoSheetItem(
                  icon: video.isViewMode
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen_rounded,
                  label: video.isViewMode ? 'Exit View' : 'View',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    if (video.isViewMode) {
                      video.isViewMode = false;
                    } else {
                      video.isViewMode = true;
                    }
                    Navigator.pop(context);
                  },
                ),
                width20,
                if (isFromFeed == true) ...[
                  VideoSheetItem(
                    icon: Icons.speed,
                    label: 'Speed',
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        builder: (context) {
                          return ReplyPlaybackSheet();
                        },
                      );
                    },
                  ),
                  width20,
                ],
                // if (isFromFeed == true) ...[
                //   VideoSheetItem(
                //     icon: Icons.keyboard_double_arrow_up_rounded,
                //     label: 'Auto-scroll',
                //     color: home.isAutoScroll
                //         ? Theme.of(context).hintColor
                //         : Theme.of(context).disabledColor,
                //     onTap: () {
                //       HapticFeedback.mediumImpact();
                //       if (home.isAutoScroll) {
                //         // home.isAutoScroll = false;
                //         getIt<SnackBarProvider>().floatingScaffold(
                //           message: 'Feature will be available soon',
                //           height: 80,
                //         );
                //       } else {
                //         // home.isAutoScroll = true;
                //         getIt<SnackBarProvider>().floatingScaffold(
                //           message: 'Feature will be available soon',
                //           height: 80,
                //         );
                //       }
                //       Navigator.of(context).pop();
                //     },
                //   ),
                //   width20,
                // ],
                VideoSheetItem(
                  icon: Icons.download_outlined,
                  label: 'Save',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    video.saveVideo(
                      videoUrl: video_link,
                      title: title,
                    );
                    Navigator.of(context).pop();
                  },
                ),
                width20,
                // Profile
                if (isFromProfile == true) ...[
                  VideoSheetItem(
                    icon: Icons.delete_outline,
                    label: 'Delete',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      final response = await home.deletePost(id: video_id!);
                      if (response == 200 || response == 201) {
                        List<Posts> post_list = profile.posts;
                        post_list.removeAt(current_index);
                        profile.posts = post_list;
                        profile.fetchProfile(username: prefs_username!);
                        Navigator.of(context, rootNavigator: true)
                          ..pop()
                          ..pop();
                        notification.show(
                          title: 'Post has been deleted',
                          type: NotificationType.local,
                        );
                      } else {
                        Navigator.pop(context);
                        notification.show(
                          title: 'Something went wrong',
                          type: NotificationType.local,
                        );
                      }
                    },
                  ),
                ],

                // Admin - Subverse
                if (isAdmin && isFromSubverse == true) ...[
                  VideoSheetItem(
                    icon: Icons.delete_outline,
                    label: 'Delete',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      final response =
                          await home.deletePostAdmin(id: video_id!);
                      if (response == 200 || response == 201) {
                        List<Posts> subverse_list = subverse.currentSortedPosts;
                        subverse_list.removeAt(current_index);
                        subverse.currentSortedPosts = subverse_list;
                        profile.fetchProfile(username: prefs_username!);
                        Navigator.of(context, rootNavigator: true)
                          ..pop()
                          ..pop();
                        notification.show(
                          title: 'Post has been deleted',
                          type: NotificationType.local,
                        );
                      } else {
                        Navigator.pop(context);
                        notification.show(
                          title: 'Something went wrong',
                          type: NotificationType.local,
                        );
                      }
                    },
                  ),
                ],

                // Admin - Feed
                if (isAdmin && isFromFeed == true) ...[
                  VideoSheetItem(
                    icon: Icons.delete_outline,
                    label: 'Delete',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      final response =
                          await reply.deletePostAdmin(id: video_id!);
                      if (response == 200 || response == 201) {
                        HapticFeedback.mediumImpact();
                        int index = current_index + 1;
                        Navigator.pop(context);
                        // home.createIsolate(token: token);
                        reply.animateToPage(index);
                        await reply.removeController(current_index);
                        List<Posts> post_list = home.posts[home.index];
                        post_list.removeAt(current_index + 1);
                        home.posts[home.index] = post_list;
                        reply.posts = home.posts[home.index].sublist(1);
                        notification.show(
                          title: 'Post has been deleted',
                          type: NotificationType.local,
                        );
                      } else {
                        Navigator.pop(context);
                        notification.show(
                          title: 'Something went wrong',
                          type: NotificationType.local,
                        );
                      }
                    },
                  ),
                ],
                width20,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
