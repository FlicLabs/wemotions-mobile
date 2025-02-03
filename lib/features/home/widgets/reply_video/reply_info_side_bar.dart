import 'package:flutter/cupertino.dart';
import 'package:socialverse/export.dart';

class ReplyInfoSideBar extends StatelessWidget {
  const ReplyInfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    final home = Provider.of<HomeProvider>(context);

    return Consumer<ReplyProvider>(
      builder: (_, __, ___) {
        final postTitle = __.posts[__.index].title;
        return Positioned(
          left: 15,
          bottom:
              video.downloading == true || video.downloadingCompleted ? 30 : 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){

                  if(__.isPlaying){
                    __.videoController(__.index)!.pause();
                    __.isPlaying=false;
                  }


                  Navigator.of(context).pushNamed(
                    UserProfileScreen.routeName,
                    arguments: UserProfileScreenArgs(
                      username: __.posts[__.index].username,
                    ),
                  ).then((value) => {

                    if(home.horizontalIndex==1){
                      __.isPlaying=true,
                      __.videoController(__.index)!.play(),
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
                        imageUrl: __.posts[__.index].pictureUrl,
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
                      children: [
                        Text(
                          __.posts[__.index].username,
                          style: AppTextStyle.normalRegular16
                        ),
                      ],
                    )
                  ],
                ),
              ),
              height10,
              if (__.posts[__.index].title.isNotEmpty) ...[
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
        );
      },
    );
  }
}
