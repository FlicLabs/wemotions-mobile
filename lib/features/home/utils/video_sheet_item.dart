import 'package:socialverse/export.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.value,
    required this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onTapDown,
  }) : super(key: key);

  final Widget icon;
  final Widget text;
  final double value;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final Function(TapDownDetails)? onTapDown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      onTapDown: onTapDown,
      child: Column(
        children: [
          icon,
          const SizedBox(height: 2),
          text,
        ],
      ),
    );
  }
}

class VideoSheet extends StatelessWidget {
  const VideoSheet({
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
    final notification = getIt<NotificationProvider>();
    final bool isAdmin = (isFromFeed == true || isFromSubverse == true) && 
        (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).canvasColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          VideoSheetItem(
            icon: Icons.file_download_rounded,
            label: 'Download',
            onTap: () {
              HapticFeedback.mediumImpact();
              video.saveVideo(videoUrl: videoLink, title: title);
              Navigator.of(context).pop();
            },
          ),
          if (isUser && isFromFeed) VideoSheetItem(
            icon: Icons.warning_rounded,
            label: 'Report',
            onTap: () {
              Navigator.of(context).pop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                builder: (context) => const ReportSheet(),
              );
            },
          ),
          if (isFromFeed == true) VideoSheetItem(
            icon: Icons.speed,
            label: 'Speed',
            onTap: () {
              HapticFeedback.mediumImpact();
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                builder: (context) => const PlaybackSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class VideoSheetItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final Color? color;
  
  const VideoSheetItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Theme.of(context).indicatorColor),
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
      ),
      onTap: onTap,
    );
  }
}

