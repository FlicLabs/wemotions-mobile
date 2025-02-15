import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/playback_sheet.dart';
import 'package:socialverse/features/home/widgets/home_video/action_sheet_item.dart';

class ReplyActionSheet extends StatelessWidget {
  const ReplyActionSheet({
    Key? key,
    required this.isUser,
    this.isCallback,
    this.isFromFeed,
    this.isFromSubverse,
    required this.currentIndex,
    required this.categoryName,
    this.categoryDesc,
    required this.categoryCount,
    required this.categoryId,
    required this.categoryPhoto,
    this.isSubscribedRequired,
    required this.title,
    required this.videoLink,
    this.isFromProfile,
    this.videoId,
  }) : super(key: key);

  final bool isUser;
  final bool? isCallback;
  final bool? isFromFeed;
  final bool? isFromSubverse;
  final int currentIndex;
  final String categoryName;
  final String? categoryDesc;
  final int categoryCount;
  final int categoryId;
  final String categoryPhoto;
  final bool? isSubscribedRequired;
  final String title;
  final String videoLink;
  final bool? isFromProfile;
  final int? videoId;

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    final notification = getIt<NotificationProvider>();

    bool isAdmin = (isFromFeed == true || isFromSubverse == true) &&
        (prefs_username == 'afrobeezy' || prefs_username == 'jack');

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
        width: cs().width(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFromFeed == true) _buildPlaybackSpeedItem(context),
            _buildCopyLinkItem(),
            _buildDownloadItem(video),
            if (isUser && isFromFeed == true) _buildReportItem(home, notification),
            if (isFromProfile == true) _buildDeleteItem(home, profile, notification),
          ],
        ),
      ),
    );
  }

  /// **Playback Speed Option**
  Widget _buildPlaybackSpeedItem(BuildContext context) {
    return Column(
      children: [
        ActionSheetItem(
          icon: Icons.speed,
          label: 'Set video Speed',
          onTap: () {
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              builder: (context) => PlaybackSheet(),
            );
          },
        ),
        height20,
      ],
    );
  }

  /// **Copy Link Option**
  Widget _buildCopyLinkItem() {
    return Column(
      children: [
        ActionSheetItem(
          svg: AppAsset.iccopy_link,
          label: 'Copy link',
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: videoLink));
            Navigator.of(context).pop();
          },
        ),
        height20,
      ],
    );
  }

  /// **Download Option**
  Widget _buildDownloadItem(VideoProvider video) {
    return Column(
      children: [
        ActionSheetItem(
          svg: AppAsset.icdownload,
          label: 'Download',
          onTap: () {
            HapticFeedback.mediumImpact();
            video.saveVideo(videoUrl: videoLink, title: title);
            Navigator.of(context).pop();
          },
        ),
        height20,
      ],
    );
  }

  /// **Report Option**
  Widget _buildReportItem(HomeProvider home, NotificationProvider notification) {
    return Column(
      children: [
        ActionSheetItem(
          svg: AppAsset.icreport,
          label: 'Report',
          onTap: () async {
            HapticFeedback.mediumImpact();
            int nextIndex = currentIndex + 1;
            Navigator.pop(context);
            home.createIsolate(token: token);
            home.animateToPage(nextIndex);

            /// Ensure safe removal without modifying provider state directly
            home.posts = List.from(home.posts)..removeAt(currentIndex);

            notification.show(
              title: 'Post has been reported',
              type: NotificationType.local,
            );
          },
        ),
        height20,
      ],
    );
  }

  /// **Delete Option for Profile**
  Widget _buildDeleteItem(HomeProvider home, ProfileProvider profile, NotificationProvider notification) {
    return ActionSheetItem(
      icon: Icons.delete_outline,
      label: 'Delete',
      onTap: () async {
        HapticFeedback.mediumImpact();
        final response = await home.deletePost(id: videoId!);
        if (response == 200 || response == 201) {
          /// Ensure safe list update
          profile.posts = List.from(profile.posts)..removeAt(currentIndex);
          profile.fetchProfile(username: prefs_username!);

          /// Close all modal dialogs
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
    );
  }
}

