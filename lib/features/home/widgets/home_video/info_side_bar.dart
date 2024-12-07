import 'package:socialverse/export.dart';

class InfoSideBar extends StatelessWidget {
  const InfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        final postTitle = __.posts[__.index][0].title;
        return Positioned(
          left: 16,
          bottom:
              video.downloading == true || video.downloadingCompleted ? 30 : 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(
                      username: __.posts[__.index][0].username,
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        fit: BoxFit.cover,
                        height: 45,
                        width: 45,
                        imageUrl: __.posts[__.index][0].pictureUrl,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Image.asset(
                          AppAsset.load,
                          fit: BoxFit.cover,
                          height: cs().height(context),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            AppAsset.icuser,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ),
                    width5,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(__.posts[__.index][0].username,
                            style: AppTextStyle.normalRegular16),
                      ],
                    )
                  ],
                ),
              ),
              height10,
              Row(
                children: [
                  // if (__.posts[__.index][0].tags.isNotEmpty) ...[
                  //   SideBarItem(
                  //     onTap: () {
                  //       __.videoController(__.index)!.pause();
                  //       showModalBottomSheet(
                  //         isScrollControlled: true,
                  //         context: context,
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.only(
                  //             topLeft: Radius.circular(30.0),
                  //             topRight: Radius.circular(30.0),
                  //           ),
                  //         ),
                  //         builder: (context) {
                  //           return AltTaggingSheet();
                  //         },
                  //       ).whenComplete(() => __.videoController(__.index)!.play());
                  //     },
                  //     value: 5,
                  //     icon: SvgPicture.asset(
                  //       AppAsset.icoptions,
                  //       color: Colors.white,
                  //       fit: BoxFit.scaleDown,
                  //     ),
                  //     text: shrink,
                  //   ),
                  //   width10
                  // ],
                  if (__.posts[__.index][0].title.isNotEmpty) ...[
                    SizedBox(
                      width: cs().width(context) - 100,
                      child: GestureDetector(
                        onTap: () => __.toggleTextExpanded(),
                        child: Linkify(
                          onOpen: (link) async {
                            if (await canLaunchUrl(Uri.parse(link.url))) {
                              await launchUrl(Uri.parse(link.url));
                            } else {
                              throw 'Could not launch $link';
                            }
                          },
                          text: postTitle,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.normalRegular,
                          textAlign: TextAlign.start,
                          maxLines: __.isTextExpanded
                              ? (5 + (6 * __.expansionProgress)).round()
                              : 1,
                          linkStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
