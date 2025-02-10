import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/helper/smooth_page_indicator.dart';
import 'package:socialverse/features/home/helper/v_video_scroll_physics.dart';
import 'package:socialverse/features/home/widgets/main_video/home_bottom_bar.dart';
import 'package:socialverse/features/home/widgets/main_video/home_side_bar.dart';

import 'home_video_progress_indicator.dart';
import 'last_page_gradient.dart';

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

  late final HomeProvider home;
  late final ReplyProvider reply;
  late final SmoothPageIndicatorProvider page;
  late final VideoProvider video;

  @override
  void initState() {
    super.initState();
    home = Provider.of<HomeProvider>(context, listen: false);
    reply = Provider.of<ReplyProvider>(context, listen: false);
    page = Provider.of<SmoothPageIndicatorProvider>(context, listen: false);
    video = Provider.of<VideoProvider>(context, listen: false);

    initializeVideo();

    _initializeReplies();

    widget.pageController.addListener(_pageListener);
  }

  Future<void> _initializeReplies() async {
    // Load initial replies in background
    unawaited(_loadInitialReplies());
  }

  Future<void> _loadInitialReplies() async {
    await home.createReplyIsolate(0, token: token);
    if (home.posts[0].length > 1) {
      reply.posts = home.posts[0].sublist(1);
      //load first reply video
      // if(reply.posts.length>=1){
      //   await reply.makeFirstHControllerReady();
      // }

    }

    // Pre fetch next page replies
    if (home.posts.length > 1) {
      unawaited(home.createReplyIsolate(1, token: token));
    }
  }

  void _initializePageIndicator() {
    page.totalVerticalPages = home.posts.length;
    page.currentVerticalIndex = home.index;
    page.totalHorizontalPages = reply.posts.length;
    page.currentHorizontalIndex = reply.index;
    print("${page.totalVerticalPages} ${page.currentVerticalIndex} ${page.totalHorizontalPages} ${page.currentHorizontalIndex} 8888888888888888888888888888888888888");
  }

  Future<void> initializeVideo() async {
    home.index = widget.pageIndex;
    await home.initializedVideoPlayer();
    reply.posts = home.posts[0].sublist(1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePageIndicator();
    });
  }


  Future<void> _handleRepliesInBackground(int idx) async {
    // Load current post replies if available
    if (home.posts[idx].length > 1) {
      reply.posts = home.posts[idx].sublist(1);
    }

    // Pre-fetch next/previous replies based on scroll direction
    if (home.vertical_drag_direction == 1) {
      if (idx + 2 <= home.posts.length - 1) {
        unawaited(home.createReplyIsolate(idx + 2, token: token));
        if (reply.posts.isNotEmpty) {
          print(reply.posts.toString()+"${idx+2}00000000000000000000000000"+reply.posts[0].id.toString());
        }
      }
    } else {
      if (idx - 2 >= 0) {
        unawaited(home.createReplyIsolate(idx - 2, token: token));
        if (reply.posts.isNotEmpty) {
          print(reply.posts.toString()+"${idx-2}00000000000000000000000000"+reply.posts[0].id.toString());
        }
      }
    }
  }

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
    return Stack(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          child: PageView.builder(
            itemCount: widget.posts.length,
            controller: widget.pageController,
            scrollDirection: Axis.vertical,
            physics: VideoScrollPhysics(),
            onPageChanged: (idx) async {

              home.vertical_drag_direction = home.index < idx ? 1 : -1;
              home.posts_page++;
              home.horizontalIndex = 0;


              home.onPageChanged(idx);

              home.isFollowing = home.posts[idx][0].following;

              home.video_trend_bar = (home.index == 0 || home.vertical_drag_direction == -1) &&
                  home.horizontalIndex == 0;

              unawaited(_handleRepliesInBackground(idx));

              _initializePageIndicator();
            },
            itemBuilder: (context, index) => _buildVideoPage(index),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPage(int index) {
    bool isInit = home.videoController(index)?.value.isInitialized ?? false;

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: home.replies,
      onPageChanged: (idx) => _handleHorizontalPageChange(idx, index),
      children: [
        _buildMainVideoContent(index, isInit),
        if (home.posts[index].length > 1 &&
            reply.posts.length == home.posts[index].length - 1)
          _buildReplyContent(index, isInit),
      ],
    );
  }

  Widget _buildMainVideoContent(int index, bool isInit) {
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
                if (!_isLastPage) ...[

                  _buildThumbnail(index),

                  if (isInit) _buildVideoPlayer(index),

                  if (home.video_trend_bar) _buildTrendingBar(),

                  if(!video.isViewMode)  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height:home.heightOfUserInfoBar,
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
                  if (!video.isViewMode) HomeUserInfoBar(),

                  PlayButton(),

                  if (!video.isViewMode) _buildSideBar(),

                  HomeVideoProgressIndicator(),

                ],
                if (_isLastPage) _buildLastPage(index, isInit),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(int index) {
    return CustomNetworkImage(
      height: cs.availableHeightWithNav(context),
      width: cs.width(context),
      imageUrl: home.posts[index][0].thumbnailUrl,
      isLoading: true,
    );
  }

  Widget _buildVideoPlayer(int index) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: home.videoController(index)!.value.size.width,
          height: home.videoController(index)!.value.size.height,
          child: VideoPlayer(home.videoController(index)!),
        ),
      ),
    );
  }

  Widget _buildTrendingBar() {
    return Positioned(
      top: -30,
      left: -10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 78),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Constants.primaryColor, width: 2),
                ),
              ),
              child: Text(
                "Trending",
                style: AppTextStyle.normalBold.copyWith(
                  color: Constants.primaryColor,
                ),
              ),
            ),
            width20,
            Text(
              "Following",
              style: AppTextStyle.normalBold.copyWith(color: Colors.white),
            ),
          ],
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
          children: [
            HomeSideBar(),
            height2,
            SmoothPageIndicatorView(),
            height15,
          ],
        ),
      ),
    );
  }

  Widget _buildLastPage(int index, bool isInit) {
    return LastPageGradient(
      isInit: isInit,
      child: SizedBox(
        width: home.videoController(index)!.value.size.width,
        height: home.videoController(index)!.value.size.height,
        child: VideoPlayer(home.videoController(index)!),
      ),
      childImage: home.posts[home.index][0].thumbnailUrl,
    );
  }

  Widget _buildReplyContent(int index, bool isInit) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => _handleReplyScroll(notification),
      child: ReplyVideoWidget(
        video: home.posts[index][0],
        pageController: reply.home,
        postIndex: 0,
        parentIndex: index,
        isInit: isInit,
      ),
    );
  }

  void _handleVideoTap(int index) {
    if (home.videoController(index)!.value.isPlaying) {
      home.isPlaying = false;
      home.videoController(index)!.pause();
    } else {
      home.isPlaying = true;
      home.videoController(index)!.play();
    }
  }

  void _handleHorizontalPageChange(int idx, int index) {

    reply.horizontal_drag_direction = reply.index < idx? 1 : -1;

    if (idx == 1) {
      home.horizontalIndex = 1;
      home.videoController(home.index)!.pause();
      reply.onReply=true;
      reply.isPlaying = true;
      home.videoController(home.index)!.seekTo(Duration.zero);
    } else if (idx == 0) {
      home.horizontalIndex = 0;
      reply.onReply=false;
      reply.horizontal_drag_direction=0;
      home.videoController(home.index)!.play();
      reply.isPlaying = false;
    }

    Future.microtask((){
      _initializePageIndicator();
    });
  }

  bool _handleReplyScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (reply.index == 0 &&
          notification.metrics.pixels < notification.metrics.minScrollExtent) {
        home.replies.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastEaseInToSlowEaseOut,
        );
      }
    }
    return false;
  }
}