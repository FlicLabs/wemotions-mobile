import 'package:socialverse/export.dart';

class HomeUserInfoBar extends StatelessWidget {
  const HomeUserInfoBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    // final reply = Provider.of<ReplyProvider>(context);
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        final postTitle = __.posts[__.index][0].title;
        return Positioned(
          left: 20,
          bottom: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {

                    if(__.isPlaying){
                      __.videoController(__.index)!.pause();
                      __.isPlaying=false;
                    }


                    Navigator.of(context).pushNamed(
                      UserProfileScreen.routeName,
                      arguments: UserProfileScreenArgs(
                        username: __.posts[__.index][0].username,
                      ),
                    ).then((value) => {
                      if(__.horizontalIndex==0){
                        __.videoController(__.index)!.play(),
                        __.isPlaying=true
                      }

                    });
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
                            height: cs.height(context),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(__.posts[__.index][0].username,
                              style: AppTextStyle.normalRegular16),
                          height2,
                          Text(
                            "Fast Replier",
                            style: AppTextStyle.normalRegular10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                height10,
                Row(
                  children: [
                    if (__.posts[__.index][0].title.isNotEmpty) ...[
                      SizedBox(
                        width: cs.width(context) - 100,
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
          ),
        );
      },
    );
  }
}
