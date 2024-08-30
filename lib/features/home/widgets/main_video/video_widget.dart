import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/helper/custom_page_view_physics.dart';
import 'package:socialverse/features/home/utils/video_sheet.dart';

class VideoWidgetArgs {
  final dynamic posts;
  final PageController pageController;
  final int pageIndex;
  final bool? isFromProfile;
  final bool? isFromSubverse;

  const VideoWidgetArgs(
      {required this.posts,
      required this.pageController,
      required this.pageIndex,
      this.isFromProfile,
      this.isFromSubverse});
}

class VideoWidget extends StatefulWidget {
  static const String routeName = '/video';
  const VideoWidget({
    Key? key,
    required this.posts,
    required this.pageController,
    required this.pageIndex,
    this.isFromProfile,
    this.isFromSubverse,
  }) : super(key: key);

  static Route route({required VideoWidgetArgs args}) {
    return ScaleRoute(
      page: VideoWidget(
        posts: args.posts,
        pageController: args.pageController,
        pageIndex: args.pageIndex,
        isFromProfile: args.isFromProfile,
        isFromSubverse: args.isFromSubverse,
      ),
    );
  }

  final dynamic posts;
  final PageController pageController;
  final int pageIndex;
  final bool? isFromProfile;
  final bool? isFromSubverse;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoProvider? _video;

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  initializeVideo() async {
    _video = Provider.of<VideoProvider>(context, listen: false);
    _video?.index = widget.pageIndex;
    await _video?.initController(widget.pageIndex, widget.posts);
  }

  @override
  void didChangeDependencies() {
    _video = Provider.of<VideoProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _video?.videoControllers.forEach((key, value) async {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    final video = Provider.of<VideoProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    final comment = Provider.of<CommentProvider>(context);
    final exit = Provider.of<ExitProvider>(context);
    bool isInit = video.videoController(video.index)!.value.isInitialized;
    return GestureDetector(
      onHorizontalDragStart: (value) {
        if (!exit.isInit) {
          comment.comment.clear();
          comment.focusNode.unfocus();
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            AnimatedContainer(
              height: cs().height(context),
              width: cs().width(context),
              transformAlignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: cs().height(context) * 0.1),
                    child: AnimatedContainer(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      transformAlignment: Alignment.topCenter,
                      duration: Duration(milliseconds: 100),
                      child: PageView.builder(
                        itemCount: widget.posts.length,
                        controller: widget.pageController,
                        physics: CustomPageViewScrollPhysics(),
                        onPageChanged: (index) {
                          if (index > video.index) {
                            video.nextVideo();
                          }
                          if (index < video.index) {
                            video.previousVideo();
                          }
                          video.index = index;
                          video.isFollowing = video.posts[index].following;
                        },
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            // onTapDown: (TapDownDetails details) {
                            //   home.setTapPosition(details.globalPosition);
                            // },
                            onDoubleTap: () {
                              // if (logged_in == true) {
                              home.handleDoubleTap();
                              // if (video.posts[index].upvoted) {
                              //   video.posts[index].upvoted = false;
                              //   video.posts[index].upvoteCount--;
                              //   home.postLikeRemove(
                              //     id: video.posts[index].id,
                              //   );
                              // } else {
                              // }
                              if (video.posts[index].upvoted == false) {
                                video.posts[index].upvoted = true;
                                video.posts[index].upvoteCount++;
                                home.postLikeAdd(
                                  id: video.posts[index].id,
                                );
                              }

                              Timer(Duration(seconds: 1),
                                  () => home.isLiked = false);

                              if (home.tapPosition != home.prevTapPosition) {
                                home.consecutiveDoubleTaps = 0;
                                home.likeAnimationScale = 1.0;
                              }

                              home.prevTapPosition = home.tapPosition;

                              home.consecutiveDoubleTaps++;
                              home.likeAnimationScale =
                                  1.0 + (home.consecutiveDoubleTaps * 0.2);
                              home.timer?.cancel();
                              home.timer = Timer(Duration(seconds: 2), () {
                                home.consecutiveDoubleTaps = 0;
                                home.likeAnimationScale = 1.0;
                              });
                              // } else {
                              //   auth.showAuthBottomSheet(context);
                              // }
                            },
                            onLongPress: () {
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
                                  return VideoSheet(
                                    isUser: video.posts[index].username !=
                                        prefs_username,
                                    isFromSubverse: widget.isFromSubverse,
                                    isFromProfile: widget.isFromProfile,
                                    isFromFeed: false,
                                    isCallback: true,
                                    category_name:
                                        video.posts[index].category.name,
                                    category_count:
                                        video.posts[index].category.count,
                                    category_id: video.posts[index].category.id,
                                    category_photo:
                                        video.posts[index].category.imageUrl,
                                    category_desc:
                                        video.posts[index].category.description,
                                    title: video.posts[index].title,
                                    video_link: video.posts[index].videoLink,
                                    video_id: video.posts[index].id,
                                    current_index: index,
                                  );
                                },
                              );
                            },
                            onTap: isKeyboardShowing
                                ? () => comment.focusNode.unfocus()
                                : () {
                                    if (video
                                        .videoController(index)!
                                        .value
                                        .isPlaying) {
                                      video.isPlaying = false;
                                      video.videoController(index)!.pause();
                                    } else {
                                      video.isPlaying = true;
                                      video.videoController(index)!.play();
                                    }
                                  },
                            child: Stack(
                              children: [
                                Container(
                                  height: cs().height(context),
                                  width: cs().width(context),
                                  decoration:
                                      BoxDecoration(color: Colors.black),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomNetworkImage(
                                        height: cs().height(context),
                                        width: cs().width(context),
                                        imageUrl:
                                            video.posts[index].thumbnailUrl,
                                      ),
                                      if (isInit) ...[
                                        SizedBox.expand(
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: SizedBox(
                                              width: video
                                                  .videoController(index)!
                                                  .value
                                                  .size
                                                  .width,
                                              height: video
                                                  .videoController(index)!
                                                  .value
                                                  .size
                                                  .height,
                                              child: VideoPlayer(
                                                video.videoController(index)!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      if (video.downloading == true)
                                        DownloadBar(
                                          height: 0,
                                          color: Colors.grey.withOpacity(0.4),
                                          label:
                                              'Saving: ${video.progressString}',
                                        ),
                                      if (video.downloadingCompleted == true)
                                        DownloadBar(
                                          height: 0,
                                          color: Theme.of(context).hintColor,
                                          label: 'Video Saved',
                                        ),
                                      video.isViewMode
                                          ? shrink
                                          : MainInfoSideBar(),
                                      MainVideoProgressIndicator(),
                                      MainPlayButton(),
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
                                      // Uncomment this
                                      // video.isViewMode
                                      //     ? shrink
                                      //     : VideoSideBar(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // uncomment this
            // video.isViewMode
            //     ? BottomSideBar()
            //     : BottomCommentBar(isKeyboardShowing: isKeyboardShowing),

            BottomSideBar(),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: Colors.white),
                surfaceTintColor: Colors.transparent,
              ),
            ),
            Consumer<ExitProvider>(
              builder: (_, __, ___) {
                return __.isInit && __.controller!.value.isInitialized
                    ? SizedBox(
                        height: cs().height(context),
                        width: cs().width(context),
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: __.controller!.value.size.width,
                              height: __.controller!.value.size.height,
                              child: VideoPlayer(__.controller!),
                            ),
                          ),
                        ),
                      )
                    : shrink;
              },
            ),
          ],
        ),
      ),
    );
  }
}
