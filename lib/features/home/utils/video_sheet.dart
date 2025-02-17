import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/playback_sheet.dart';
import 'package:socialverse/features/home/utils/report_sheet.dart';

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

    bool isAdmin = (isFromFeed == true || isFromSubverse == true) &&
        (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    bool canReportFromFeed = isUser == true && isFromFeed == true;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      width: cs().width(context),
      child: Column(
        children: [
          height20,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                VideoSheetItemSVG(
                  iconSVG: SvgPicture.asset(
                    AppAsset.iclink,
                    width: 24,
                    height: 24,
                    color: Theme.of(context).indicatorColor,
                  ),
                  label: 'Copy link',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.of(context).pop();
                  },
                ),
                height30,
                VideoSheetItem(
                  icon: Icons.file_download_rounded,
                  label: 'Download',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    video.saveVideo(videoUrl: videoLink, title: title);
                    Navigator.of(context).pop();
                  },
                ),
                height30,
                VideoSheetItem(
                  icon: Icons.report_problem_rounded,
                  label: 'Report',
                  onTap: () => Navigator.of(context).pop(),
                ),
                if (canReportFromFeed) height30,
                if (canReportFromFeed)
                  VideoSheetItem(
                    icon: Icons.warning_rounded,
                    label: 'Report',
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.pop(context);
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        builder: (context) => ReportSheet(),
                      );
                    },
                  ),
                if (canReportFromFeed) height30,
                if (canReportFromFeed)
                  VideoSheetItem(
                    icon: Icons.heart_broken_outlined,
                    label: 'Not Vibing',
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      await home.blockPost(id: videoId!);
                      int index = currentIndex + 1;
                      Navigator.pop(context);
                      home.createIsolate(token: token);
                      home.animateToPage(index);
                      await home.removeController(currentIndex);
                      home.posts.removeAt(currentIndex);
                      notification.show(
                        title: 'We will show you fewer videos like this',
                        type: NotificationType.local,
                      );
                    },
                  ),
                height30,
                if (isFromFeed == true)
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
                        builder: (context) => PlaybackSheet(),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
