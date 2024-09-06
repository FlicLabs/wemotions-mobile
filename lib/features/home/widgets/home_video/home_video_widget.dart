import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/helper/custom_page_view_physics.dart';
import 'package:socialverse/features/home/utils/video_sheet.dart';
import 'package:socialverse/features/home/widgets/home_video/last_page_gradient.dart';
import 'package:socialverse/features/home/widgets/reply_video/reply_video_widget.dart';

import 'package:socialverse/features/home/providers/reply_provider.dart';

class HomeVideoWidget extends StatefulWidget {
  const HomeVideoWidget({
    Key? key,
    required this.posts,
    required this.pageController,
    required this.pageIndex,
    required this.isFromFeed,
  }) : super(key: key);

  final List<Posts> posts;
  final PageController pageController;
  final int pageIndex;
  final bool isFromFeed;

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
    await home.initializedVideoPlayer();
    home.index = widget.pageIndex;
    reply.posts = home.hPosts;
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
    reply.posts = home.hPosts;
    double nav = MediaQuery.of(context).size.height * 0.0595;
    double available = MediaQuery.of(context).size.height - nav;
    return Stack(
      children: [
        AnimatedContainer(
          height: available,
          width: MediaQuery.of(context).size.width,
          transformAlignment: Alignment.topCenter,
          duration: Duration(milliseconds: 100),
          child: PageView.builder(
            itemCount: widget.posts.length,
            controller: widget.pageController,
            physics: CustomPageViewScrollPhysics(),
            onPageChanged: (index) async {
              home.posts_page++;
              home.fetchingReplies = true;
              home.horizontalIndex = 0;
              home.createReplyIsolate(home.posts[index]);
              home.onPageChanged(index);
              home.index = index;
              home.isFollowing = home.posts[index].following;
            },
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              bool isInit = home.videoController(index)!.value.isInitialized;
              return PageView(
                onPageChanged: (value) {
                  if (value == 1) {
                    home.horizontalIndex = 1;
                    home.videoController(home.index)!.pause();

                    home.videoController(home.index)!.seekTo(Duration.zero);
                  } else if (value == 0) {
                    home.horizontalIndex = 0;
                    home.videoController(home.index)!.play();
                  }
                },
                scrollDirection: Axis.horizontal,
                controller: home.replies,
                children: [
                  Listener(
                    onPointerDown: (PointerDownEvent event) {
                      home.setTapPosition(event.position);
                    },
                    child: GestureDetector(
                      onDoubleTap: () {
                        home.handleDoubleTap();

                        if (home.posts[index].upvoted == false) {
                          home.posts[index].upvoted = true;
                          home.posts[index].upvoteCount++;
                          home.postLikeAdd(id: home.posts[index].id);
                        }

                        Timer(Duration(seconds: 1), () => home.isLiked = false);

                        if (home.tapPosition != home.prevTapPosition) {
                          home.consecutiveDoubleTaps = 0;
                          home.likeAnimationScale = 1.0;
                        }

                        home.prevTapPosition = home.tapPosition;

                        home.consecutiveDoubleTaps++;
                        home.likeAnimationScale =
                            1.0 + (home.consecutiveDoubleTaps * 0.2);
                        home.timer?.cancel();
                        home.timer = Timer(
                          Duration(seconds: 2),
                          () {
                            home.consecutiveDoubleTaps = 0;
                            home.likeAnimationScale = 1.0;
                          },
                        );
                      },
                      onLongPress: () async {
                        HapticFeedback.mediumImpact();
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
                              isUser:
                                  home.posts[index].username != prefs_username,
                              isFromFeed: widget.isFromFeed,
                              video_id: home.posts[index].id,
                              category_name: '',
                              category_count: 0,
                              category_id: 0,
                              category_photo: '',
                              category_desc: '',
                              title: home.posts[index].title,
                              video_link: home.posts[index].videoLink,
                              current_index: index,
                            );
                          },
                        );
                      },
                      onTap: () {
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
                                    height: cs().height(context),
                                    width: cs().width(context),
                                    imageUrl: home.posts[index].thumbnailUrl,
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
                                if (_isLastPage) ...[
                                  LastPageGradient(
                                    isInit: isInit,
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
                                ],
                                if (video.downloading == true)
                                  DownloadBar(
                                    color: Colors.grey.withOpacity(0.4),
                                    label: 'Saving: ${video.progressString}',
                                  ),
                                if (video.downloadingCompleted == true)
                                  DownloadBar(
                                    color: Theme.of(context).hintColor,
                                    label: 'Video Saved',
                                  ),
                                if (!_isLastPage) ...[
                                  video.isViewMode ? shrink : InfoSideBar(),
                                ],
                                if (!_isLastPage) PlayButton(),
                                if (home.isLiked) ...[
                                  Positioned(
                                    left: home.tapPosition.dx - 75,
                                    top: home.tapPosition.dy - 150,
                                    child: SafeArea(
                                      child: Transform.scale(
                                        scale: home.likeAnimationScale,
                                        child: Image.asset(
                                          AppAsset.like,
                                          color: Colors.white,
                                          height: 150,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                                if (!_isLastPage) ...[
                                  video.isViewMode ? shrink : HomeSideBar(),
                                ],
                                HomeVideoProgressIndicator(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (reply.posts.isNotEmpty &&
                      home.fetchingReplies == false) ...[
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
                          video: home.posts[index],
                          pageController: value.home,
                          postIndex: 0,
                          parentIndex: index,
                          isInit: isInit,
                        );
                      }),
                    )
                  ]
                ],
              );
              /*
                  When replies have been fetched, control moves to the reply provider.
                  Since new video controller is created for horizontal feed, the video restarts.
                  Happens due to the delay in fetching replies.
                  */
            },
          ),
        ),
        if (reply.posts.isNotEmpty && home.fetchingReplies == false) ...[
          Positioned(
            right: reply.posts.length == 2
                ? -18
                : reply.posts.length == 0
                    ? 18
                    : 0,
            top: 240,
            child: AnimatedSmoothIndicator(
              // controller: reply.home,
              count: reply.posts.length + 1,
              activeIndex: home.horizontalIndex,
              effect: ScrollingDotsEffect(
                  maxVisibleDots: 3,
                  fixedCenter: true,
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey),
            ),
          ),
        ],
        Positioned(
          right: 20,
          top: home.posts.length == 3
              ? 202
              : home.posts.length == 1
                  ? 238
                  : 220,
          child: SmoothPageIndicator(
            controller: widget.pageController,
            axisDirection: Axis.vertical,
            count: home.posts.length,
            effect: ScrollingDotsEffect(
                maxVisibleDots: 3,
                fixedCenter: true,
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.white,
                dotColor: Colors.grey),
          ),
        ),
      ],
    );
  }
}
