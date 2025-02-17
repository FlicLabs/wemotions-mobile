import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/playback_sheet.dart';
import 'package:socialverse/features/home/widgets/home_video/action_sheet_item.dart';

class ActionSheet extends StatelessWidget {
  const ActionSheet({
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
    final profile = Provider.of<ProfileProvider>(context);
    final notification = getIt<NotificationProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        color: Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 3,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar for UX
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 15),

          if (isFromFeed == true) ...[
            _buildActionItem(
              context,
              icon: Icons.speed,
              label: 'Set Video Speed',
              onTap: () {
                HapticFeedback.lightImpact();
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
          ],

          _buildActionItem(
            context,
            svg: AppAsset.iccopy_link,
            label: 'Copy Link',
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: video_link));
              Navigator.of(context).pop();
              notification.show(title: 'Link copied!', type: NotificationType.local);
            },
          ),

          _buildActionItem(
            context,
            svg: AppAsset.icdownload,
            label: 'Download Video',
            onTap: () {
              HapticFeedback.lightImpact();
              video.saveVideo(videoUrl: video_link, title: title);
              Navigator.of(context).pop();
              notification.show(title: 'Download started!', type: NotificationType.local);
            },
          ),

          if (isUser == true && isFromFeed == true) ...[
            _buildActionItem(
              context,
              svg: AppAsset.icreport,
              label: 'Report Video',
              color: Colors.redAccent,
              onTap: () async {
                HapticFeedback.mediumImpact();
                Navigator.pop(context);
                home.createIsolate(token: token);
                home.animateToPage(current_index + 1);
                await home.removeController(current_index);
                home.posts.removeAt(current_index);
                notification.show(title: 'Post reported.', type: NotificationType.local);
              },
            ),
          ],

          if (isFromProfile == true) ...[
            _buildActionItem(
              context,
              icon: Icons.delete_outline,
              label: 'Delete Video',
              color: Colors.red,
              onTap: () async {
                HapticFeedback.mediumImpact();
                final response = await home.deletePost(id: video_id!);
                if (response == 200 || response == 201) {
                  profile.posts.removeAt(current_index);
                  profile.fetchProfile(username: prefs_username!);
                  Navigator.of(context, rootNavigator: true)..pop()..pop();
                  notification.show(title: 'Post deleted.', type: NotificationType.local);
                } else {
                  Navigator.pop(context);
                  notification.show(title: 'Something went wrong.', type: NotificationType.local);
                }
              },
            ),
          ],

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    IconData? icon,
    String? svg,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      onTap: onTap,
      leading: svg != null
          ? SvgPicture.asset(svg, height: 24, width: 24, color: color ?? Theme.of(context).iconTheme.color)
          : Icon(icon, color: color ?? Theme.of(context).iconTheme.color),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

