import 'package:socialverse/export.dart';

class BottomSideBar extends StatelessWidget {
  const BottomSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    bool isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');
    return Consumer<VideoProvider>(
      builder: (_, __, ___) {
        // dynamic count = __.posts[__.index].commentCount;
        return Positioned(
          bottom: 0,
          child: Container(
            width: cs().width(context),
            height: cs().height(context) * 0.1,
            color: Colors.grey.shade900,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // CustomCircularAvatar(
                      //   height: 45,
                      //   width: 50,
                      //   imageUrl: __.posts[__.index].pictureUrl,
                      //   onTap: () {
                      //     if (__.videoController(__.index)!.value.isPlaying) {
                      //       __.videoController(__.index)!.pause();
                      //     }
                      //     if (logged_in == true) {
                      //       Navigator.of(context)
                      //           .pushNamed(
                      //             ProfileScreen.routeName,
                      //             arguments: ProfileScreenArgs(
                      //               username: __.posts[__.index].username,
                      //               mainUser: false,
                      //               isFollowing: (isFollowing) {
                      //                 __.posts[__.index].following =
                      //                     isFollowing;
                      //               },
                      //             ),
                      //           )
                      //           .then(
                      //             (value) =>
                      //                 __.videoController(__.index)!.play(),
                      //           );
                      //       log(__.posts[__.index].username);
                      //     } else {
                      //       auth.showAuthBottomSheet(context);
                      //     }
                      //   },
                      // ),
                      SideBarItem(
                        onTap: () {
                          if (logged_in == true) {
                            if (__.posts[__.index].upvoted) {
                              __.posts[__.index].upvoted = false;
                              __.posts[__.index].upvoteCount--;
                              home.postLikeRemove(
                                id: __.posts[__.index].id,
                              );
                            } else {
                              __.posts[__.index].upvoted = true;
                              __.posts[__.index].upvoteCount++;
                              home.postLikeAdd(
                                id: __.posts[__.index].id,
                              );
                            }
                          } else {
                            auth.showAuthBottomSheet(context);
                          }
                        },
                        value: 14,
                        icon: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return __.posts[__.index].upvoted
                                ? LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[
                                      Theme.of(context).hintColor,
                                      Colors.pink,
                                      Theme.of(context).hintColor,
                                    ],
                                    tileMode: TileMode.repeated,
                                  ).createShader(bounds)
                                : const LinearGradient(
                                    colors: <Color>[Colors.white, Colors.white],
                                  ).createShader(bounds);
                          },
                          child: SvgPicture.asset(
                            AppAsset.iclike,
                            color: Colors.white,
                          ),
                        ),
                        text: shrink,
                      ),
                      // SideBarItem(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //       constraints: BoxConstraints(
                      //         maxHeight: cs().height(context) / 1.35,
                      //       ),
                      //       isScrollControlled: true,
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only(
                      //           topRight: Radius.circular(30),
                      //           topLeft: Radius.circular(30),
                      //         ),
                      //       ),
                      //       context: context,
                      //       builder: (context) {
                      //         return FractionallySizedBox(
                      //           heightFactor: 1,
                      //           child: Consumer<CommentProvider>(
                      //             builder: (context, value, child) {
                      //               if (value.update_count == true) {
                      //                 count += 1;
                      //                 __.posts[__.index].commentCount = count;
                      //               }
                      //               return HomeCommentWidget(
                      //                 id: __.posts[__.index].id,
                      //               );
                      //             },
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      //   value: 14,
                      //   icon: SvgPicture.asset(
                      //     AppAsset.iccomment,
                      //     color: Colors.white,
                      //   ),
                      //   text: shrink,
                      // ),
                      SideBarItem(
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          bool isUser =
                              __.posts[__.index].username != prefs_username;
                         
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
                                isUser: isUser,
                                dynamicLink: 'link',
                              );
                            },
                          );
                        },
                        value: 0,
                        icon: Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Icon(
                            UniconsLine.share,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        text: shrink,
                      ),
                      // SideBarItem(
                      //   onTap: () {
                      //     HapticFeedback.mediumImpact();
                      //     if (__.isViewMode) {
                      //       __.isViewMode = false;
                      //     } else {
                      //       __.isViewMode = true;
                      //     }
                      //   },
                      //   value: 5,
                      //   icon: Icon(
                      //     Icons.fullscreen_rounded,
                      //     color: Colors.white,
                      //     size: 25,
                      //   ),
                      //   text: shrink,
                      // ),
                      SideBarItem(
                        onTap: () async {
                          HapticFeedback.heavyImpact();
                          if (__.videoController(__.index)!.value.isPlaying) {
                            await __.videoController(__.index)!.pause();
                          }
                          home.showInspiredDialog(
                            context,
                            id: __.posts[__.index].id,
                          );
                        },
                        value: 10,
                        icon: Image.asset(
                          AppAsset.icon,
                        ),
                        text: shrink,
                      ),
                      if (isAdmin) ...[
                        SideBarItem(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            __.posts[__.index].exitCount += 1;
                            __.updateExitCount(
                              id: __.posts[__.index].id,
                            );
                          },
                          value: 5,
                          icon: Center(
                            child: Text(
                              '${__.posts[__.index].exitCount}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'sofia',
                              ),
                            ),
                          ),
                          text: shrink,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
