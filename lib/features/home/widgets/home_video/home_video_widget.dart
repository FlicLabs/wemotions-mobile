import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/helper/smooth_page_indicator.dart';
import 'package:socialverse/features/home/widgets/main_video/home_bottom_bar.dart';
import 'package:socialverse/features/home/widgets/main_video/home_side_bar.dart';

class HomeVideoWidget extends StatefulWidget {
  final List<List<Posts>> posts;
  final PageController pageController;
  final int pageIndex;
  final bool isFromFeed;

  const HomeVideoWidget({
    Key? key,
    required this.posts,
    required this.pageController,
    required this.pageIndex,
    required this.isFromFeed,
  }) : super(key: key);

  @override
  State<HomeVideoWidget> createState() => _HomeVideoWidgetState();
}

class _HomeVideoWidgetState extends State<HomeVideoWidget> {
  int _previousPage = 0;
  bool _isLastPage = false;

  @override
  void initState() {
    initializeVideo();
    widget.pageController.addListener(_pageListener);
    super.initState();
  }



  initializeVideo() async {
    final home = Provider.of<HomeProvider>(context, listen: false);
    final reply = Provider.of<ReplyProvider>(context, listen: false);
    // final navigation = Provider.of<BottomNavBarProvider>(context, listen: false);
    await home.initializedVideoPlayer();
    home.index = widget.pageIndex;
    reply.posts = home.posts[0].sublist(1);
    print("=======================");
    print(reply.posts.map((e) => e.username).toList());
    // navigation.parentVideoId = home.posts[widget.pageIndex][0].id;

  }



  void _pageListener() {
    final currentPage = widget.pageController.page?.round() ?? 0;
    final lastPage = widget.posts.length - 1;

    if (currentPage == lastPage && _previousPage != lastPage) {
      setState(() {
        _isLastPage = true;
      });
    } else if (currentPage != lastPage && _isLastPage) {
      setState(() {
        _isLastPage = false;
      });
    }

    _previousPage = currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final video = Provider.of<VideoProvider>(context);
    final reply = Provider.of<ReplyProvider>(context);

    var pageIndicatorProvider =
        Provider.of<SmoothPageIndicatorProvider>(context);


    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          child: PageView.builder(
            itemCount: widget.posts.length,
            controller: widget.pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (idx) {
              pageIndicatorProvider.setMaxVertical(widget.posts.length);
              pageIndicatorProvider.scrollVertical(idx);


              if(home.index<idx){
                home.vertical_drag_direction=1;
              }else{
                home.vertical_drag_direction=-1;
              }

              home.posts_page++;
              home.fetchingReplies = true;
              home.horizontalIndex = 0;
              reply.posts = home.posts[idx].sublist(1);
              if (home.index < idx) {
                if (idx + 2 <= home.posts.length - 1) {
                  home.createReplyIsolate(idx + 2, token: token);
                }
              } else if (home.index > idx) {
                if (idx - 2 >= 0) {
                  home.createReplyIsolate(idx - 2, token: token);
                }
              }
              // home.createReplyIsolate(home.post_forReply++, token: token);
              home.onPageChanged(idx);
              home.index = idx;
              home.isFollowing = home.posts[idx][0].following;
              // navigation.parentVideoId = home.posts[idx][0].id;


              if((home.index==0 || home.vertical_drag_direction==-1) && home.horizontalIndex==0){
                home.video_trend_bar=true;
              }else{
                home.video_trend_bar=false;
              }



            },
            itemBuilder: (_, index) {
              pageIndicatorProvider.setMaxHorizontal(reply.posts.length);
              pageIndicatorProvider.setMaxVertical(home.posts.length);
              bool isInit =
                  home.videoController(index)!.value.isInitialized;
              return PageView(
                scrollDirection: Axis.horizontal,
                controller: home.replies,
                onPageChanged: (idx) {
                  // pageIndicatorProvider.setMaxHorizontal(reply.posts.length);
                  pageIndicatorProvider.scrollHorizontal(idx);

                  // print(pageIndicatorProvider.maxHorizontal.toString()+"}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                  // print(pageIndicatorProvider.horizontalIndex.toString()+"}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
                  // print(pageIndicatorProvider.hidePlaceHorizontal.toString()+"}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");


                  if (idx == 1) {
                    home.horizontalIndex = 1;
                    home.videoController(home.index)!.pause();
                    reply.isPlaying = true;
                    home.videoController(home.index)!.seekTo(Duration.zero);

                  } else if (idx == 0) {
                    home.horizontalIndex = 0;
                    home.videoController(home.index)!.play();
                    reply.isPlaying = false;

                  }




                },
                children: [
                  Listener(
                    child: GestureDetector(
                      onTap: (){
                        if (home.videoController(index)!.value.isPlaying) {
                          home.isPlaying = false;
                          home.videoController(index)!.pause();
                        } else {
                          home.isPlaying = true;
                          home.videoController(index)!.play();
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (!_isLastPage) ...[
                                  CustomNetworkImage(
                                    height: cs.height(context),
                                    width: cs.width(context),
                                    imageUrl:
                                        home.posts[index][0].thumbnailUrl,
                                    isLoading: true,
                                  ),
                                ],


                                if (isInit && !_isLastPage) ...[
                                  SizedBox.expand(
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        width: home
                                            .videoController(index)!
                                            .value
                                            .size
                                            .width,
                                        height: home
                                            .videoController(index)!
                                            .value
                                            .size
                                            .height,
                                        child: VideoPlayer(
                                          home.videoController(index)!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                                if(home.video_trend_bar && !_isLastPage)
                                  Positioned(
                                    top:-30,
                                    left:-10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 78),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration:  BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(color: Constants.primaryColor,width: 2)),
                                            ),
                                            child: Text("Trending",style: AppTextStyle.normalBold.copyWith(color: Constants.primaryColor)),
                                          ),
                                          width20,
                                          Text("Following",style: AppTextStyle.normalBold.copyWith(color: Colors.white)),

                                        ],
                                      ),
                                    ),
                                  ),

                                if (!_isLastPage) ...[
                                  video.isViewMode
                                      ? shrink
                                      : HomeUserInfoBar(),
                                ],
                                // if (!_isLastPage) PlayButton(),
                                // if (homeProvider.isLiked) ...[
                                //   Positioned(
                                //     left: home.tapPosition.dx - 75,
                                //     top: home.tapPosition.dy - 150,
                                //     child: SafeArea(
                                //       child: Transform.scale(
                                //         scale: home.likeAnimationScale,
                                //         child: Image.asset(
                                //           AppAsset.like,
                                //           color: Colors.white,
                                //           height: 150,
                                //         ),
                                //       ),
                                //     ),
                                //   )
                                // ],
                                if (!_isLastPage) PlayButton(),

                                if (!_isLastPage) ...[
                                  video.isViewMode
                                      ? shrink
                                      : Positioned(
                                          bottom: 15,
                                          right: 0,
                                          child: Container(
                                            width: cs.width(context) / 4.5,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                HomeSideBar(),
                                                height2,
                                                SmoothPageIndicatorView(),
                                                height15
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  if (home.posts[index].length > 1 &&
                      reply.posts.length == home.posts[index].length - 1) ...[
                    NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification is ScrollUpdateNotification) {
                          if (reply.index == 0 &&
                              notification.metrics.pixels <
                                  notification.metrics.minScrollExtent) {
                            home.replies.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.fastEaseInToSlowEaseOut,
                            );
                          }
                        }
                        return false;
                      },
                      child: Consumer<ReplyProvider>(
                          builder: (context, value, child) {
                            return ReplyVideoWidget(
                              video: home.posts[index][0],
                              pageController: value.home,
                              postIndex: 0,
                              parentIndex: index,
                              isInit: isInit,
                            );
                          }),
                    )
                  ],

                  //just for demo single post
                  // Container(
                  //   height: MediaQuery.of(context).size.height,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black,
                  //   ),
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       if (!_isLastPage) ...[
                  //         CustomNetworkImage(
                  //           height: cs.height(context),
                  //           width: cs.width(context),
                  //           imageUrl:
                  //           home.posts[index][0].thumbnailUrl,
                  //           isLoading: true,
                  //         ),
                  //       ],
                  //       if (isInit && !_isLastPage) ...[
                  //         SizedBox.expand(
                  //           child: FittedBox(
                  //             fit: BoxFit.cover,
                  //             child: SizedBox(
                  //               width: home
                  //                   .videoController(index)!
                  //                   .value
                  //                   .size
                  //                   .width,
                  //               height: home
                  //                   .videoController(index)!
                  //                   .value
                  //                   .size
                  //                   .height,
                  //               child: VideoPlayer(
                  //                 home.videoController(index)!,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //
                  //       if (!_isLastPage) ...[
                  //         video.isViewMode
                  //             ? shrink
                  //             : HomeUserInfoBar(),
                  //       ],
                  //       // if (!_isLastPage) PlayButton(),
                  //       // if (homeProvider.isLiked) ...[
                  //       //   Positioned(
                  //       //     left: home.tapPosition.dx - 75,
                  //       //     top: home.tapPosition.dy - 150,
                  //       //     child: SafeArea(
                  //       //       child: Transform.scale(
                  //       //         scale: home.likeAnimationScale,
                  //       //         child: Image.asset(
                  //       //           AppAsset.like,
                  //       //           color: Colors.white,
                  //       //           height: 150,
                  //       //         ),
                  //       //       ),
                  //       //     ),
                  //       //   )
                  //       // ],
                  //       if (!_isLastPage) ...[
                  //         video.isViewMode
                  //             ? shrink
                  //             : Positioned(
                  //           bottom: 15,
                  //           right: 0,
                  //           child: Container(
                  //             width: cs.width(context) / 4.5,
                  //             child: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: [
                  //                 HomeSideBar(),
                  //                 height2,
                  //                 SmoothPageIndicatorView(),
                  //                 height15
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(
                  //   height: cs.height(context),
                  //   width: cs.width(context),
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         color: Colors.black,
                  //         height: cs.height(context),
                  //         width: cs.width(context),
                  //         child: Center(child: Text("$idx*10",style: AppTextStyle.normalRegular20,)),
                  //       ),
                  //       Positioned(
                  //         bottom: 15,
                  //         right: 0,
                  //         child: Container(
                  //           width: cs.width(context)/4.5,
                  //           // color: Colors.red,
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               HomeSideBar(),
                  //               height2,
                  //               SmoothPageIndicatorView(),
                  //               height15
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       HomeUserInfoBar(),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: cs.height(context),
                  //   width: cs.width(context),
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         color: Colors.black,
                  //         height: cs.height(context),
                  //         width: cs.width(context),
                  //         child: Center(child: Text("$idx*100",style: AppTextStyle.normalRegular20,)),
                  //       ),
                  //       Positioned(
                  //         bottom: 15,
                  //         right: 0,
                  //         child: Container(
                  //           width: cs.width(context)/4.5,
                  //           // color: Colors.red,
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               HomeSideBar(),
                  //               height2,
                  //               SmoothPageIndicatorView(),
                  //               height15
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       HomeUserInfoBar(),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: cs.height(context),
                  //   width: cs.width(context),
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         color: Colors.black,
                  //         height: cs.height(context),
                  //         width: cs.width(context),
                  //         child: Center(child: Text("$idx*1000",style: AppTextStyle.normalRegular20,)),
                  //       ),
                  //       Positioned(
                  //         bottom: 15,
                  //         right: 0,
                  //         child: Container(
                  //           width: cs.width(context)/4.5,
                  //           // color: Colors.red,
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               HomeSideBar(),
                  //               height2,
                  //               SmoothPageIndicatorView(),
                  //               height15
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       HomeUserInfoBar(),
                  //     ],
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
