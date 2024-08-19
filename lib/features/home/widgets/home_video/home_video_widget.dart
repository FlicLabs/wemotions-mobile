import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/helper/custom_page_view_physics.dart';
import 'package:socialverse/features/home/utils/custom_heart_widget.dart';
import 'package:socialverse/features/home/utils/video_sheet.dart';
import 'package:socialverse/features/home/widgets/home_video/last_page_gradient.dart';

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
    await home.initializedVideoPlayer();
    home.index = widget.pageIndex;
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
    final spectrum = Provider.of<SpectrumProvider>(context);
    final video = Provider.of<VideoProvider>(context);
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
            onPageChanged: (index) {
              home.posts_page++;
              home.onPageChanged(index);
              home.index = index;
              home.isFollowing = home.posts[index].following;
            },
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              bool isInit = home.videoController(index)!.value.isInitialized;
              return Listener(
                onPointerDown: (PointerDownEvent event) {
                  if (!_isLastPage) {
                    if (isInit && logged_in!) {
                      spectrum.startSwipe(event.position.dy);
                    }
                    home.setTapPosition(event.position);
                  }
                },
                onPointerMove: (PointerMoveEvent event) {
                  if (!_isLastPage) {
                    if (isInit && logged_in!) {
                      spectrum.updateSwipe(event.position.dy, context);
                    }
                  }
                },
                onPointerUp: (PointerUpEvent event) {
                  if (!_isLastPage) {
                    if (isInit && logged_in!) {
                      spectrum.endSwipe(home.posts[index].id);
                    }
                  }
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
                          isUser: home.posts[index].username != prefs_username,
                          isFromFeed: widget.isFromFeed,
                          video_id: home.posts[index].id,
                          category_name: home.posts[index].category.name,
                          category_count: home.posts[index].category.count,
                          category_id: home.posts[index].category.id,
                          category_photo: home.posts[index].category.imageUrl,
                          category_desc: home.posts[index].category.description,
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
              );
            },
          ),
        ),
        if (spectrum.isSwiping && spectrum.ratingValue != 0) ...[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: cs().height(context),
              width: cs().width(context),
              color: Colors.black.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${spectrum.ratingValue.round()}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomHeartWidget(fillPercentage: spectrum.ratingValue)
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
