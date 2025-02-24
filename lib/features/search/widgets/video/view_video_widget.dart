import 'package:socialverse/export.dart';
import 'package:socialverse/features/search/providers/video_provider.dart';

import '../../../home/helper/v_video_scroll_physics.dart';

class ViewVideoWidgetArgs {
  final List posts;
  final PageController pageController;
  final int pageIndex;


  ViewVideoWidgetArgs({
    required this.posts,
    required this.pageController,
    required this.pageIndex,
  });
}


class ViewVideoWidget extends StatefulWidget {

  static const routeName = '/view-video';

  final List posts;
  final PageController pageController;
  final int pageIndex;

  const ViewVideoWidget({
    Key? key,
    required this.posts,
    required this.pageController,
    required this.pageIndex,
  }) : super(key: key);

  static Route route({required ViewVideoWidgetArgs args}) {
    return MaterialPageRoute(
      builder: (_) => ViewVideoWidget(
        posts: args.posts,
        pageController: args.pageController,
        pageIndex: args.pageIndex,
      ),
    );
  }

  @override
  State<ViewVideoWidget> createState() => _ViewVideoWidgetState();
}

class _ViewVideoWidgetState extends State<ViewVideoWidget> {
  int _previousPage = 0;
  bool _isLastPage = false;
  //
  // late final HomeProvider home;
  // late final ReplyProvider reply;
  late final SmoothPageIndicatorProvider page;
  late final ViewVideoProvider viewVideo;

  @override
  void initState() {
    super.initState();
    // home = Provider.of<HomeProvider>(context, listen: false);
    // reply = Provider.of<ReplyProvider>(context, listen: false);
    page = Provider.of<SmoothPageIndicatorProvider>(context, listen: false);
    viewVideo = Provider.of<ViewVideoProvider>(context, listen: false);

    initializeVideo();

    // _initializeReplies();

    widget.pageController.addListener(_pageListener);
  }

  // Future<void> _initializeReplies() async {
  //   // Load initial replies in background
  //   unawaited(_loadInitialReplies());
  // }

  // Future<void> _loadInitialReplies() async {
  //   await home.createReplyIsolate(0, token: token);
  //   if (home.posts[0].length > 1) {
  //     reply.posts = home.posts[0].sublist(1);
  //     //load first reply video
  //     // if(reply.posts.length>=1){
  //     //   await reply.makeFirstHControllerReady();
  //     // }
  //
  //   }
  //
  //   // Pre fetch next page replies
  //   if (home.posts.length > 1) {
  //     unawaited(home.createReplyIsolate(1, token: token));
  //   }
  // }

  // void _initializePageIndicator() {
  //   print(reply.posts.length.toString()+"/////////////////////////////////////////////////");
  //   page.onReply = reply.onReply;
  //   page.totalVerticalPages = home.posts.length;
  //   page.currentVerticalIndex = home.index;
  //   page.totalHorizontalPages = reply.posts.length;
  //   page.currentHorizontalIndex = reply.index;
  //   print("${page.totalVerticalPages} ${page.currentVerticalIndex} ${page.totalHorizontalPages} ${page.currentHorizontalIndex} 8888888888888888888888888888888888888");
  // }

  Future<void> initializeVideo() async {



    WidgetsBinding.instance.addPostFrameCallback(await (_) async{
      viewVideo.posts=widget.posts;
      // print("mmmmmmmmmmmmmmmmmmmmmmmmm111111111111");
      await viewVideo.initializedVideoPlayer(widget.pageIndex);
      // print("mmmmmmmmmmmmmmmmmmmmmmmmm22222222222222");
    });


    // reply.posts = viewVideo.posts[0].sublist(1);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   home.index = widget.pageIndex;
    //   _initializePageIndicator();
    // });
  }


  // Future<void> _handleRepliesInBackground(int idx) async {
  //   // Load current post replies if available
  //   if (home.posts[idx].length > 1) {
  //     reply.posts = home.posts[idx].sublist(1);
  //   }
  //
  //   // Pre-fetch next/previous replies based on scroll direction
  //   if (home.vertical_drag_direction == 1) {
  //     if (idx + 2 <= home.posts.length - 1) {
  //       unawaited(home.createReplyIsolate(idx + 2, token: token));
  //       if (reply.posts.isNotEmpty) {
  //         print(reply.posts.toString()+"${idx+2}00000000000000000000000000"+reply.posts[0].id.toString());
  //       }
  //     }
  //   } else {
  //     if (idx - 2 >= 0) {
  //       unawaited(home.createReplyIsolate(idx - 2, token: token));
  //       if (reply.posts.isNotEmpty) {
  //         print(reply.posts.toString()+"${idx-2}00000000000000000000000000"+reply.posts[0].id.toString());
  //       }
  //     }
  //   }
  // }

  void _pageListener() {
    final currentPage = widget.pageController.page?.round() ?? 0;
    final lastPage = widget.posts.length - 1;

    if (currentPage == lastPage && _previousPage != lastPage) {
      setState(() => _isLastPage = true);
    } else if (currentPage != lastPage && _isLastPage) {
      setState(() => _isLastPage = false);
    }

    _previousPage = currentPage;
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) async{
        if(val){
          await viewVideo.goingBack();
        }
      },
      canPop: true,
      child: Hero(
        tag: 'videoIndex_${widget.pageIndex}',
        child: Consumer2<ViewVideoProvider,SmoothPageIndicatorProvider>(
          builder: (_,__,___,____){

            if (__.posts.isEmpty) {
              return Center(child: CustomProgressIndicator());
            }

            return Scaffold(
              body: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    child: PageView.builder(
                      itemCount: widget.posts.length,
                      controller: widget.pageController,
                      scrollDirection: Axis.vertical,
                      physics: VideoScrollPhysics(),
                      onPageChanged: (idx) async {

                        __.vertical_drag_direction = viewVideo.index < idx ? 1 : -1;


                        // // reset variable
                        // if(home.horizontalIndex!=0){
                        //   home.horizontalIndex = 0;
                        // }
                        // if(reply.onReply!=false){
                        //   print(reply.index.toString());
                        //   await reply.videoController(reply.index)?..pause();
                        //   await reply.videoController(reply.index)?..seekTo(Duration.zero);
                        //   // reply.isPlaying
                        //   reply.onReply=false;
                        // }
                        //
                        // if(home.posts[idx].length == 1){
                        //   reply.posts.clear();
                        // }


                        __.onPageChanged(idx);

                        __.isFollowing = viewVideo.posts[idx].following;


                        // unawaited(_handleRepliesInBackground(idx));

                        // _initializePageIndicator();
                      },
                      itemBuilder: (context, index)  {
                        return _buildVideoPage(index,__);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildVideoPage(int index,ViewVideoProvider __) {



    return PageView(
      scrollDirection: Axis.horizontal,
      // controller: viewVideo.replies,
      // onPageChanged: (idx) => _handleHorizontalPageChange(idx, index),
      children: [
        _buildMainVideoContent(index,__),
      ],
    );
  }

  Widget _buildMainVideoContent(int index,ViewVideoProvider __) {
    return GestureDetector(
      onTap: () => _handleVideoTap(index),
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.black),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ...[

                  _buildThumbnail(index,__),

                  if (__.isInitialized) _buildVideoPlayer(index,__),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height:__.heightOfUserInfoBar,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Colors.black12.withOpacity(0.56),
                              Colors.black12.withOpacity(0.56),
                              Colors.black12.withOpacity(0.46),
                              Colors.black12.withOpacity(0.34),
                              Colors.black12.withOpacity(0.24),
                              Colors.black12.withOpacity(0.24),
                              Colors.black12.withOpacity(0.21),
                              Colors.black12.withOpacity(0.18),
                              Colors.black12.withOpacity(0.12),
                              Colors.black12.withOpacity(0.08),
                              Colors.black12.withOpacity(0.04),
                              Colors.black12.withOpacity(0.0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter
                        ),
                        borderRadius: BorderRadius.circular(8),

                      ),
                    ),
                  ),
                  VideoUserInfoBar(),

                  if(!__.isPlaying)
                    Container(
                      color: Colors.black12.withOpacity(0.04),
                      height: cs.height(context),
                      width: cs.width(context),
                    ),

                  // Center(
                  //   child: Container(
                  //     color: Colors.black12,
                  //     height: 100,
                  //     width: 100,
                  //     child: Text('$index',style: TextStyle(color: Colors.white),),
                  //   ),
                  // ),


                  _buildSideBar(),

                  ViewVideoProgressIndicator(),

                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(int index,ViewVideoProvider __) {
    return CustomNetworkImage(
      height: cs.availableHeightWithNav(context),
      width: cs.width(context),
      imageUrl: __.posts[index].thumbnailUrl,
      isLoading: true,
    );
  }

  Widget _buildVideoPlayer(int index,ViewVideoProvider __) {

    if (__.videoController(index) == null) {

      return const SizedBox.shrink();
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: __.videoController(index)!.value.size.width,
          height: __.videoController(index)!.value.size.height,
          child: VideoPlayer(__.videoController(index)!),
        ),
      ),
    );
  }


  Widget _buildSideBar() {
    return Positioned(
      bottom: 15,
      right: 0,
      child: Container(
        width: cs.width(context) / 4.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VideoSideBar(),
            height60,
            // SmoothPageIndicatorView(),
            height15,
          ],
        ),
      ),
    );
  }


  // Widget _buildReplyContent(int index, bool isInit) {
  //   return NotificationListener<ScrollNotification>(
  //     onNotification: (notification) => _handleReplyScroll(notification),
  //     child: ReplyVideoWidget(
  //       video: home.posts[index][0],
  //       pageController: reply.home,
  //       postIndex: 0,
  //       parentIndex: index,
  //       isInit: isInit,
  //     ),
  //   );
  // }

  void _handleVideoTap(int index) {
    if(viewVideo.videoController(index)==null) return;

    if (viewVideo.videoController(index)!.value.isPlaying) {
      viewVideo.isPlaying = false;
      viewVideo.videoController(index)!.pause();
    } else {
      viewVideo.isPlaying = true;
      viewVideo.videoController(index)!.play();
    }
  }

  // void _handleHorizontalPageChange(int idx, int index) async{
  //
  //   reply.horizontal_drag_direction = reply.index < idx? 1 : -1;
  //
  //   if (idx == 1) {
  //     home.horizontalIndex = 1;
  //
  //     await home.videoController(home.index)?.pause();
  //     await home.videoController(home.index)?.seekTo(Duration.zero);
  //
  //     reply.onReply=true;
  //     reply.isPlaying = true;
  //
  //     reply.videoController(reply.index)?.setLooping(true);
  //     reply.videoController(reply.index)?.play();
  //
  //
  //   } else if (idx == 0) {
  //     home.horizontalIndex = 0;
  //
  //     reply.videoController(reply.index)?.pause();
  //     reply.videoController(reply.index)?.seekTo(Duration.zero);
  //
  //     reply.onReply=false;
  //     reply.horizontal_drag_direction=0;
  //     reply.isPlaying = false;
  //
  //     home.videoController(home.index)!.play();
  //
  //
  //   }
  //
  //   Future.microtask((){
  //     _initializePageIndicator();
  //   });
  // }

  // bool _handleReplyScroll(ScrollNotification notification) {
  //   if (notification is ScrollUpdateNotification) {
  //     if (reply.index == 0 &&
  //         notification.metrics.pixels < notification.metrics.minScrollExtent) {
  //       home.replies.animateToPage(
  //         0,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.fastEaseInToSlowEaseOut,
  //       );
  //     }
  //   }
  //   return false;
  // }
}




class VideoUserInfoBar extends StatelessWidget {
  const VideoUserInfoBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewVideoProvider>(
      builder: (_, __, ___) {
        final postTitle = __.posts[__.index].title;
        return Positioned(
          left: 20,
          bottom: 25,
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
                        username: __.posts[__.index].username,
                      ),
                    ).then((value) => {

                      __.videoController(__.index)!.play(),
                      __.isPlaying=true

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(__.posts[__.index].username,
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
              ],
            ),
          ),
        );
      },
    );
  }
}


class VideoSideBar extends StatelessWidget {
  const VideoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<ViewVideoProvider>(
      builder: (_, __, ___) {
        return !__.isInitialized
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
                                __.posts[__.index].upvoteCount--;
                                __.posts[__.index].upvoted = false;
                                __.postLikeRemove(
                                  id: __.posts[__.index].id,
                                );
                              } else {
                                __.posts[__.index].upvoteCount++;
                                __.posts[__.index].upvoted = true;

                                __.postLikeAdd(
                                  id: __.posts[__.index].id,
                                );
                              }
                            },
                            value: 14,
                            icon: SvgPicture.asset(
                              AppAsset.icWemotionsLogo,
                              fit: BoxFit.scaleDown,
                              color: __.posts[__.index].upvoted
                                  ? Constants.primaryColor
                                  : Colors.white,
                            ),
                            text: Text(
                              __.posts[__.index].upvoteCount
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
                          // SideBarItem(
                          //   onTap: () async {
                          //     final currentPage =
                          //         __.replies.page?.round() ?? 0;
                          //     final totalPages =
                          //         __.posts[__.index].length - 1;
                          //     if (currentPage < totalPages) {
                          //       await __.replies.animateToPage(
                          //         currentPage + 1,
                          //         duration:
                          //         const Duration(milliseconds: 300),
                          //         curve: Curves.easeInOut,
                          //       );
                          //     }
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
                          //     (__.posts[__.index][0].childVideoCount)
                          //         .toString(),
                          //     style: TextStyle(
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w400,
                          //       color: Colors.white,
                          //       fontFamily: 'sofia',
                          //     ),
                          //   ),
                          // ), //Share
                          // height16,
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

class ViewVideoProgressIndicator extends StatelessWidget {
  const ViewVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewVideoProvider>(
      builder: (_, __, ___) {
        final controller = __.videoController(__.index);

        if (controller == null) {
          return Positioned(
            bottom: -1,
            child: SizedBox(
              height: 9.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  const LinearProgressIndicator(value: 0)
                ],
              ),
            ),
          );
        }
        if (!controller.value.isInitialized) {

          return Positioned(
            bottom: -1,
            child: SizedBox(
              height: 9.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  const LinearProgressIndicator(value: 0)
                ],
              ),
            ),
          );
        }

        return Positioned(
          bottom: -1,
          child: SizedBox(
            height: 9.5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [


                VideoProgressIndicator(
                  __.videoController(__.index)!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    bufferedColor: Colors.white,
                    backgroundColor: Colors.white,
                    playedColor: Theme.of(context).hintColor,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
