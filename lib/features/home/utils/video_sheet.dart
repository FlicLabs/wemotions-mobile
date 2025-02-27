import 'package:socialverse/export.dart';
import 'package:socialverse/features/search/providers/video_provider.dart';

class VideoSheet extends StatelessWidget {
  const VideoSheet({
    Key? key,
    required this.isUser,
    this.isFromFeed,
    this.isFromSubverse,
    required this.current_index,
    required this.title,
    required this.video_link,
    this.isFromProfile,
    this.video_id,
  }) : super(key: key);

  final bool isUser;
  final bool? isFromFeed;
  final bool? isFromSubverse;
  final int current_index;
  final String title;
  final String video_link;
  final bool? isFromProfile;
  final int? video_id;

  @override
  Widget build(BuildContext context) {

    final video = Provider.of<ViewVideoProvider>(context);

    // bool isAdmin = isFromFeed == true ||
    //     isFromSubverse == true &&
    //         (prefs_username == 'afrobeezy' || prefs_username == 'jack');
    //
    // print(
    //   'isAdmin: $isAdmin, isFromSubverse: $isFromSubverse, isFromProfile: $isFromProfile',
    // );

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 220,
        width: cs.width(context),
        child: Column(
          children: [
            height40,
            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VideoSheetItemSVG(
                        iconSVG: SvgPicture.asset(
                          AppAsset.icLink,
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
                      VideoSheetItemSVG(
                        iconSVG: SvgPicture.asset(
                          AppAsset.directDownload,
                          width: 24,
                          height: 24,
                          color: Theme.of(context).indicatorColor,
                        ),
                        label: 'Download',
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          // video.saveVideo(
                          //   videoUrl: video_link,
                          //   title: title,
                          // );
                          Navigator.of(context).pop();
                        },
                      ),
                      height30,
                      VideoSheetItemSVG(
                        iconSVG: SvgPicture.asset(
                          AppAsset.icReport,
                          width: 24,
                          height: 24,
                          color: Theme.of(context).indicatorColor,
                        ),
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
                            builder: (context) {
                              return ReportSheet();
                            },
                          );
                        },
                      ),

                      height30,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
