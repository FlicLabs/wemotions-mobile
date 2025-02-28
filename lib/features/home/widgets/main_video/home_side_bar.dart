import 'package:socialverse/export.dart';

class HomeSideBar extends StatelessWidget {
  const HomeSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return __.posts.isEmpty
            ? shrink
            : Container(
                height: cs.height(context),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                SideBarItem(
                                  onTap: () {
                                    if (__.posts[__.index][0].upvoted) {
                                      if (logged_in!) {
                                        __.posts[__.index][0].upvoteCount--;
                                        __.posts[__.index][0].upvoted = false;
                                      }
                                      __.postLikeRemove(
                                        id: __.posts[__.index][0].id,
                                      );
                                    } else {
                                      if (logged_in!) {
                                        __.posts[__.index][0].upvoteCount++;
                                        __.posts[__.index][0].upvoted = true;
                                      }
                                      __.postLikeAdd(
                                        id: __.posts[__.index][0].id,
                                      );
                                    }
                                  },
                                  onLongPress: () {
                                    // HapticFeedback.mediumImpact();
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   backgroundColor: Colors.black,
                                    //   shape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.only(
                                    //       topLeft: Radius.circular(30.0),
                                    //       topRight: Radius.circular(30.0),
                                    //     ),
                                    //   ),
                                    //   builder: (context) {
                                    //     return MotionSheet();
                                    //   },
                                    // );
                                  },
                                  value: 14,
                                  icon: SvgPicture.asset(
                                    AppAsset.icWemotionsLogo,
                                    fit: BoxFit.scaleDown,
                                    color: __.posts[__.index][0].upvoted
                                        ? Constants.primaryColor
                                        : Colors.white,
                                  ),
                                  text: Text(
                                    __.posts[__.index][0].upvoteCount
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontFamily: 'sofia',
                                    ),
                                  ),
                                ), //Upvote
                                height16,
                                SideBarItem(
                                  onTap: () async {
                                    HapticFeedback.mediumImpact();

                                    if (__
                                        .videoController(__.index)!
                                        .value
                                        .isPlaying) {
                                      await __
                                          .videoController(__.index)!
                                          .pause();
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
                                        return ShareSheet(
                                          dynamicLink: 'link',
                                        );
                                      },
                                    ).then(
                                      (value) =>
                                          __.videoController(__.index)!.play(),
                                    );
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
                                    (__.posts[__.index][0].shareCount)
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
                                // SideBarItem(
                                //   onTap: () async {
                                //     if (__
                                //             .videoController(__.index)!
                                //             .value
                                //             .isPlaying ??
                                //         false) {
                                //       await __.videoController(__.index)
                                //         ?..pause();
                                //     }

                                //     showModalBottomSheet(
                                //       context: context,
                                //       shape: const RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.only(
                                //           topLeft: Radius.circular(30.0),
                                //           topRight: Radius.circular(30.0),
                                //         ),
                                //       ),
                                //       builder: (context) {
                                //         return VideoSheet(
                                //           isUser:
                                //               __.posts[__.index][0].username !=
                                //                   prefs_username,
                                //           isFromFeed: true,
                                //           video_id: __.posts[__.index][0].id,
                                //           title: __.posts[__.index][0].title,
                                //           video_link:
                                //               __.posts[__.index][0].videoLink,
                                //           current_index: __.index,
                                //         );
                                //       },
                                //     ).then((value) async {
                                //       if (!__
                                //               .videoController(__.index)!
                                //               .value
                                //               .isPlaying ??
                                //           false) {
                                //         await __.videoController(__.index)
                                //           ?..play();
                                //       }
                                //     });
                                //   },
                                //   value: 5,
                                //   icon: Icon(
                                //     Icons.more_vert,
                                //     color: Colors.white,
                                //     size: 27,
                                //   ),
                                //   text: shrink,
                                // ),
                                // height10,
                              ],
                            ),
                          ),
                          height10,
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
