import 'package:socialverse/export.dart';

class HomeSideBar extends StatelessWidget {
  const HomeSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return false
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
                                    if (__.posts[__.index][0].upvoted) {
                                      __.posts[__.index][0].upvoteCount--;
                                      __.posts[__.index][0].upvoted = false;
                                      __.postLikeRemove(
                                        id: __.posts[__.index][0].id,
                                      );
                                    } else {
                                      __.posts[__.index][0].upvoteCount++;
                                      __.posts[__.index][0].upvoted = true;

                                      __.postLikeAdd(
                                        id: __.posts[__.index][0].id,
                                      );
                                    }
                                  },
                                  onLongPress: (){
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
                                    final currentPage =
                                        __.replies.page?.round() ?? 0;
                                    final totalPages =
                                        __.posts[__.index].length - 1;
                                    if (currentPage < totalPages) {
                                      await __.replies.animateToPage(
                                        currentPage + 1,
                                        duration:
                                        const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  value: 0,
                                  icon: Padding(
                                    padding: EdgeInsets.only(bottom: 3),
                                    child: SvgPicture.asset(
                                      AppAsset.icVideo,
                                      color: Colors.white,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  text: Text(
                                    (__.posts[__.index][0].childVideoCount)
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
                                  onTap: () async {
                                    HapticFeedback.mediumImpact();
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
                                SideBarItem(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        ),
                                      ),
                                      builder: (context) {
                                        return VideoSheet(
                                          isUser: true,
                                          isFromFeed: true,
                                          video_id: 0,
                                          title: "title",
                                          video_link: "videoLink",
                                          current_index: 0,
                                        );
                                      },
                                    );
                                  },
                                  value: 5,
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                                  text: shrink,
                                ),
                                height16,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
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
