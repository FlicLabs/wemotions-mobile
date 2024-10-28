import 'dart:ui';

import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/widgets/home_video/alt_voting_sheet.dart';
import 'package:socialverse/features/home/widgets/home_video/home_actions_sheet.dart';
import 'package:socialverse/features/home/widgets/home_video/tagging_widget.dart';

class HomeSideBar extends StatelessWidget {
  const HomeSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    bool isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        //dynamic count = __.posts[__.index].commentCount;
        return __.posts.isEmpty
            ? shrink
            : Positioned(
                bottom: 120,
                right: 10,
                child: Container(
                  height: cs().height(context),
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
                                  // SideBarItem(
                                  //   onTap: () async {
                                  //     // This is parent_video_id
                                  //     // .posts[.index].id
                                  //     // print(__.posts[__.index].id.toString());
                                  //
                                  //     if (logged_in == false) {
                                  //       auth.showAuthBottomSheet(context);
                                  //     } else {
                                  //       PermissionStatus status =
                                  //           await Permission.camera.request();
                                  //       if (status.isDenied ||
                                  //           status.isPermanentlyDenied) {
                                  //         showDialog(
                                  //           context: context,
                                  //           builder: (context) =>
                                  //               CustomAlertDialog(
                                  //             title: 'Permission Denied',
                                  //             action: 'Open Settings',
                                  //             content:
                                  //                 'Please allow access to camera to record videos',
                                  //             tap: () {
                                  //               openAppSettings();
                                  //             },
                                  //           ),
                                  //         );
                                  //       } else {
                                  //         PermissionStatus status =
                                  //             await Permission.camera.request();
                                  //         if (status.isDenied ||
                                  //             status.isPermanentlyDenied) {
                                  //           showDialog(
                                  //             context: context,
                                  //             builder: (context) =>
                                  //                 CustomAlertDialog(
                                  //               title: 'Permission Denied',
                                  //               action: 'Open Settings',
                                  //               content:
                                  //                   'Please allow access to camera to record videos',
                                  //               tap: () {
                                  //                 openAppSettings();
                                  //               },
                                  //             ),
                                  //           );
                                  //         } else {
                                  //           await availableCameras().then(
                                  //             (value) => Navigator.of(context)
                                  //                 .pushNamed(
                                  //               CameraScreen.routeName,
                                  //               arguments: CameraScreenArgs(
                                  //                   cameras: value,
                                  //                   isReply: true,
                                  //                   parent_video_id: __
                                  //                       .posts[__.index][0].id
                                  //                       .toString()),
                                  //             ),
                                  //           );
                                  //         }
                                  //       }
                                  //     }
                                  //   },
                                  //   value: 0,
                                  //   icon: SvgPicture.asset(
                                  //     AppAsset.icreply,
                                  //     color: Colors.white,
                                  //     fit: BoxFit.scaleDown,
                                  //   ),
                                  //   text: Text(
                                  //     // (__.posts[__.index].length - 1)
                                  //     //     .toString(),
                                  //     "Reply",
                                  //     style: TextStyle(
                                  //       fontSize: 10,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: Colors.white,
                                  //       fontFamily: 'sofia',
                                  //     ),
                                  //   ),
                                  // ), //Reply
                                  // height16,
                                  SideBarItem(
                                    onTap: () {
                                      if (__.posts[__.index][0].upvoted) {
                                        __.posts[__.index][0].upvoted = false;
                                        __.posts[__.index][0].upvoteCount--;
                                        __.postLikeRemove(
                                          id: __.posts[__.index][0].id,
                                        );
                                      } else {
                                        __.posts[__.index][0].upvoted = true;
                                        __.posts[__.index][0].upvoteCount++;
                                        __.postLikeAdd(
                                          id: __.posts[__.index][0].id,
                                        );
                                      }
                                    },
                                    // onTapDown: (position) {
                                    //   __.getTapPosition(context, position);
                                    // },
                                    // onLongPress: () async {
                                    //   // HapticFeedback.mediumImpact();
                                    //   // __.isSlider = true;
                                    //   __.showContextMenu(
                                    //     context,
                                    //     id: __.posts[__.index].id,
                                    //     rate_value:
                                    //         __.posts[__.index].ratingCount,
                                    //   );
                                    // },
                                    value: 14,
                                    icon: SvgPicture.asset(
                                      AppAsset.icwemotionslogo,
                                      color: __.posts[__.index][0].upvoted ? Color(0xFFA858F4) : Colors.white,
                                      fit: BoxFit.scaleDown,
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
                                  // height16,
                                  // SideBarItem(
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
                                  //           return TaggingWidget();
                                  //         },
                                  //       ).whenComplete(() {
                                  //         __.searched_users.clear();
                                  //         __.searchController.clear();
                                  //       });
                                  //     },
                                  //     value: 5,
                                  //     icon: Icon(
                                  //       Icons.tag,
                                  //       color: Colors.white,
                                  //     ),
                                  //     text: shrink
                                  //     // Text(
                                  //     //   __.posts[__.index][0].voting_count
                                  //     //       .toString(),
                                  //     //   style: TextStyle(
                                  //     //     fontSize: 13,
                                  //     //     fontWeight: FontWeight.w400,
                                  //     //     color: Colors.white,
                                  //     //     fontFamily: 'sofia',
                                  //     //   ),
                                  //     // ),
                                  //     ), //Voting
                                  // height10,
                                  // SideBarItem(
                                  //   onTap: () {
                                  //     // __.videoController(__.index)!.pause();
                                  //     showModalBottomSheet(
                                  //       barrierColor: Colors.transparent,
                                  //       backgroundColor: Colors.transparent,
                                  //       isScrollControlled: true,
                                  //       context: context,
                                  //       shape: const RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.only(
                                  //           topLeft: Radius.circular(30.0),
                                  //           topRight: Radius.circular(30.0),
                                  //         ),
                                  //       ),
                                  //       builder: (context) {
                                  //         return ClipRRect(
                                  //           borderRadius: BorderRadius.only(
                                  //             topLeft: Radius.circular(30.0),
                                  //             topRight: Radius.circular(30.0),
                                  //           ),
                                  //           child: BackdropFilter(
                                  //             filter: ImageFilter.blur(
                                  //                 sigmaX: 10.0,
                                  //                 sigmaY:
                                  //                     10.0), // Set the blur amount
                                  //             child: Container(
                                  //               color:
                                  //                   Colors.black.withOpacity(0),
                                  //               child: AltVotingSheet(),
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   value: 5,
                                  //   icon: Icon(
                                  //     Icons.emoji_emotions,
                                  //     color: Colors.white,
                                  //   ),
                                  //   text: Text(
                                  //     __.posts[__.index][0].voting_count
                                  //         .toString(),
                                  //     style: TextStyle(
                                  //       fontSize: 13,
                                  //       fontWeight: FontWeight.w400,
                                  //       color: Colors.white,
                                  //       fontFamily: 'sofia',
                                  //     ),
                                  //   ),
                                  // ), //Tagging
                                  height10,
                                  SideBarItem(
                                    onTap: () async {
                                      HapticFeedback.mediumImpact();
                                      bool isUser =
                                          __.posts[__.index][0].username !=
                                              prefs_username;
                                      final link =
                                      await __.dynamicLink.createPostLink(
                                        imageUrl:
                                        __.posts[__.index][0].thumbnailUrl,
                                        postID: '${__.posts[__.index][0].id}',
                                        username:
                                        __.posts[__.index][0].username,
                                        description:
                                        __.posts[__.index][0].title,
                                        isPost: true,
                                      );
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
                                            dynamicLink: link,
                                          );
                                        },
                                      );
                                    },
                                    value: 0,
                                    icon: Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: SvgPicture.asset(
                                        AppAsset.icvideo,
                                        color: Colors.white,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    text: Text(
                                      // (__.posts[__.index][0].shareCount)
                                      //     .toString(),
                                      "0",
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
                                      bool isUser =
                                          __.posts[__.index][0].username !=
                                              prefs_username;
                                      final link =
                                          await __.dynamicLink.createPostLink(
                                        imageUrl:
                                            __.posts[__.index][0].thumbnailUrl,
                                        postID: '${__.posts[__.index][0].id}',
                                        username:
                                            __.posts[__.index][0].username,
                                        description:
                                            __.posts[__.index][0].title,
                                        isPost: true,
                                      );
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
                                            dynamicLink: link,
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
                                            isUser: __.posts[__.index][0].username !=
                                                prefs_username,
                                            isFromFeed: true,
                                            video_id: __.posts[__.index][0].id,
                                            category_name: '',
                                            category_count: 0,
                                            category_id: 0,
                                            category_photo: '',
                                            category_desc: '',
                                            title: __.posts[__.index][0].title,
                                            video_link: __.posts[__.index][0].videoLink,
                                            current_index: __.index,
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
                                    // Text(
                                    //   'View',
                                    //   style: TextStyle(
                                    //     fontSize: 13,
                                    //     fontWeight: FontWeight.w400,
                                    //     color: Colors.white,
                                    //     fontFamily: 'sofia',
                                    //   ),
                                    // ),
                                  ),
                                  height16,
                                  // SideBarItem(
                                  //   onTap: () {
                                  //     HapticFeedback.lightImpact();
                                  //     if (video.isViewMode) {
                                  //       video.isViewMode = false;
                                  //     } else {
                                  //       video.isViewMode = true;
                                  //     }
                                  //   },
                                  //   value: 5,
                                  //   icon: Icon(
                                  //     Icons.fullscreen_rounded,
                                  //     color: Colors.white,
                                  //     size: 25,
                                  //   ),
                                  //   text: shrink,
                                  //   // Text(
                                  //   //   'View',
                                  //   //   style: TextStyle(
                                  //   //     fontSize: 13,
                                  //   //     fontWeight: FontWeight.w400,
                                  //   //     color: Colors.white,
                                  //   //     fontFamily: 'sofia',
                                  //   //   ),
                                  //   // ),
                                  // ),
                                  // height10,
                                  // SideBarItem(
                                  //   onTap: () async {
                                  //     HapticFeedback.heavyImpact();
                                  //     if (__
                                  //         .videoController(__.index)!
                                  //         .value
                                  //         .isPlaying) {
                                  //       await __
                                  //           .videoController(__.index)!
                                  //           .pause();
                                  //     }
                                  //     __.showInspiredDialog(
                                  //       context,
                                  //       id: __.posts[__.index][0].id,
                                  //     );
                                  //   },
                                  //   value: 10,
                                    // icon: Image.asset(
                                    //   AppAsset.icon,
                                    // ),
                                  //   text: shrink,
                                  // ),
                                  if (isAdmin) ...[
                                    SideBarItem(
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        __.posts[__.index][0].exitCount += 1;
                                        __.updateExitCount(
                                          id: __.posts[__.index][0].id,
                                        );
                                      },
                                      value: 5,
                                      icon: Center(
                                        child: Text(
                                          '${__.posts[__.index][0].exitCount}',
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
                            ),
                            SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
