import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/widgets/reply_video/reply_video_replys.dart';
import 'package:socialverse/features/home/widgets/reply_video/reply_video_sheet.dart';
import 'package:socialverse/features/search/providers/video_provider.dart';

class ReplySideBar extends StatelessWidget {
  const ReplySideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<ViewVideoProvider>(context);
    bool isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    return Consumer<ReplyProvider>(
      builder: (_, __, ___) {
        //dynamic count = __.posts[__.index].commentCount;
        return __.posts.isEmpty
            ? shrink
            : Container(
              height: cs.height(context),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Column(
                            children: [
                              SideBarItem(
                                onTap: () {
                                  if (__.posts[__.index].upvoted) {
                                    __.posts[__.index].upvoted = false;
                                    __.posts[__.index].upvoteCount--;
                                    __.postLikeRemove(
                                      id: __.posts[__.index].id,
                                    );
                                  } else {
                                    __.posts[__.index].upvoted = true;
                                    __.posts[__.index].upvoteCount++;
                                    __.postLikeAdd(
                                      id: __.posts[__.index].id,
                                    );
                                  }
                                },
                                value: 14,
                                icon: SvgPicture.asset(
                                  AppAsset.icWemotionsLogo,
                                  color: __.posts[__.index].upvoted
                                      ? Color(0xFFA858F4)
                                      : Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                                text: Text(
                                  __.posts[__.index].upvoteCount.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: 'sofia',
                                  ),
                                ),
                              ), //Upvote
                              height16,

                              // SideBarItem(
                              //   onTap: () async {
                              //
                              //     showModalBottomSheet(
                              //       context: context,
                              //       backgroundColor: Colors.black,
                              //       shape: const RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(30.0),
                              //           topRight: Radius.circular(30.0),
                              //         ),
                              //       ),
                              //       builder: (context) {
                              //         return VideoReplySheet();
                              //       },
                              //     );
                              //
                              //   },
                              //   value: 0,
                              //   icon: Padding(
                              //     padding: EdgeInsets.only(bottom: 3),
                              //     child: SvgPicture.asset(
                              //       AppAsset.icVideo,
                              //       color: Colors.white,
                              //       fit: BoxFit.scaleDown,
                              //     ),
                              //   ),
                              //   text: Text(
                              //     ('0')
                              //         .toString(),
                              //     style: TextStyle(
                              //       fontSize: 13,
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.white,
                              //       fontFamily: 'sofia',
                              //     ),
                              //   ),
                              // ),
                              //
                              // height16,
                              SideBarItem(
                                onTap: () async {
                                  HapticFeedback.mediumImpact();
                                  bool isUser =
                                      __.posts[__.index].username !=
                                          prefs_username;

                                  if(__.videoController(__.index)!.value.isPlaying ?? false){
                                    await __.videoController(__.index)?..pause();
                                  }

                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.black,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return ShareSheet();
                                    },
                                  ).then((value) async {
                                    if(!__.videoController(__.index)!.value.isPlaying ?? false){
                                      await __.videoController(__.index)?..play();
                                    }
                                  });

                                },
                                value: 0,
                                icon: Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: SvgPicture.asset(
                                    AppAsset.icShare,
                                    color: Colors.white,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                text: Text(
                                  (__.posts[__.index].shareCount)
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    fontFamily: 'sofia',
                                  ),
                                ),
                              ), //Share
                              height16,

                              SideBarItem(
                                onTap: () async{

                                  if(__.videoController(__.index)!.value.isPlaying ?? false){
                                    await __.videoController(__.index)?..pause();
                                  }

                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return ReplyActionSheet(
                                        isUser:
                                            __.posts[__.index].username !=
                                                prefs_username,
                                        isFromFeed: true,
                                        video_id: __.posts[__.index].id,
                                        category_name: '',
                                        category_count: 0,
                                        category_id: 0,
                                        category_photo: '',
                                        category_desc: '',
                                        title: __.posts[__.index].title,
                                        video_link:
                                            __.posts[__.index].videoLink,
                                        current_index: __.index,
                                      );
                                    },
                                  ).then((value) async {
                                    if(!__.videoController(__.index)!.value.isPlaying ?? false){
                                      await __.videoController(__.index)?..play();
                                    }
                                  });
                                },
                                value: 5,
                                icon: SvgPicture.asset(
                                  AppAsset.icoptions,
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                ),
                                text: shrink,
                              ), //Options
                              height10,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: video.downloading == true ||
                                  video.downloadingCompleted
                              ? 40
                              : 40,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
