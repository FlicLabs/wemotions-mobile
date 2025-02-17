import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/export.dart'; // Make sure this import is correct
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG

class HomeSideBar extends StatelessWidget {
  const HomeSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access providers
    final homeProvider = Provider.of<HomeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final videoProvider = Provider.of<VideoProvider>(context); // If used

    bool isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    return homeProvider.posts.isEmpty
        ? const SizedBox.shrink() // Use SizedBox.shrink for empty state
        : Positioned(
            bottom: 120,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height, // Use MediaQuery
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        // ... (Other SideBarItems)

                        SideBarItem(
                          onTap: () {
                            if (homeProvider.posts[homeProvider.index][0].upvoted) {
                              homeProvider.posts[homeProvider.index][0].upvoted = false;
                              homeProvider.posts[homeProvider.index][0].upvoteCount--;
                              homeProvider.postLikeRemove(
                                id: homeProvider.posts[homeProvider.index][0].id,
                              );
                            } else {
                              homeProvider.posts[homeProvider.index][0].upvoted = true;
                              homeProvider.posts[homeProvider.index][0].upvoteCount++;
                              homeProvider.postLikeAdd(
                                id: homeProvider.posts[homeProvider.index][0].id,
                              );
                            }
                          },
                          value: 14,
                          icon: SvgPicture.asset(
                            AppAsset.icwemotionslogo,
                            color: homeProvider.posts[homeProvider.index][0].upvoted
                                ? const Color(0xFFA858F4)
                                : Colors.white,
                            fit: BoxFit.scaleDown,
                          ),
                          text: Text(
                            homeProvider.posts[homeProvider.index][0].upvoteCount.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'sofia',
                            ),
                          ),
                        ), //Upvote

                        // ... (Other SideBarItems)

                        SideBarItem(
                          onTap: () async {
                            final currentPage = homeProvider.replies.page?.round() ?? 0;
                            final totalPages = homeProvider.posts[homeProvider.index].length - 1;
                            if (currentPage < totalPages) {
                              await homeProvider.replies.animateToPage(
                                currentPage + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          value: 0,
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: SvgPicture.asset(
                              AppAsset.icvideo,
                              color: Colors.white,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          text: Text(
                            homeProvider.posts[homeProvider.index][0].childVideoCount.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'sofia',
                            ),
                          ),
                        ), //Share

                        // ... (Other SideBarItems)

                        SideBarItem(
                          onTap: () async {
                            HapticFeedback.mediumImpact();
                            bool isUser = homeProvider.posts[homeProvider.index][0].username != prefs_username;
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
                            padding: const EdgeInsets.only(bottom: 3),
                            child: SvgPicture.asset(
                              AppAsset.icShare,
                              color: Colors.white,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          text: Text(
                            homeProvider.posts[homeProvider.index][0].shareCount.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'sofia',
                            ),
                          ),
                        ), //Share

                        // ... (Other SideBarItems)

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
                                  isUser: homeProvider.posts[homeProvider.index][0].username != prefs_username,
                                  isFromFeed: true,
                                  video_id: homeProvider.posts[homeProvider.index][0].id,
                                  category_name: '',
                                  category_count: 0,
                                  category_id: 0,
                                  category_photo: '',
                                  category_desc: '',
                                  title: homeProvider.posts[homeProvider.index][0].title,
                                  video_link: homeProvider.posts[homeProvider.index][0].videoLink,
                                  current_index: homeProvider.index,
                                );
                              },
                            );
                          },
                          value: 5,
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 27,
                          ),
                          text: const SizedBox.shrink(), // No text needed here
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
