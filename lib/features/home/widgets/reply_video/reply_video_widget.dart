import 'package:socialverse/export.dart';

class ReplyVideoWidget extends StatefulWidget {
  final Posts video;
  final PageController pageController;
  final int postIndex;
  final int parentIndex;
  final bool isInit;
  const ReplyVideoWidget({
    super.key,
    required this.video,
    required this.pageController,
    required this.postIndex,
    required this.parentIndex,
    required this.isInit,
  });

  @override
  State<ReplyVideoWidget> createState() => _ReplyVideoWidgetState();
}

class _ReplyVideoWidgetState extends State<ReplyVideoWidget> {
  ReplyProvider? _reply;

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  initializeVideo() async {
    _reply = Provider.of<ReplyProvider>(context, listen: false);
    await _reply?.initializedVideoPlayer();
    _reply?.index = widget.postIndex;
  }

  @override
  void didChangeDependencies() {
    _reply = Provider.of<ReplyProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _reply?.controllers.forEach((key, value) async {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reply = Provider.of<ReplyProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    final video = Provider.of<VideoProvider>(context);
    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            home.horizontalIndex = index + 1;
            reply.onPageChanged(index);
            reply.index = index;
            reply.isFollowing = reply.posts[index].following;
          },
          controller: widget.pageController,
          physics: CustomBouncingScrollPhysics(),
          itemCount: reply.posts.length,
          itemBuilder: (context, index) {
            bool isReplyInit =
                reply.videoController(index)!.value.isInitialized;
            return Stack(
              children: [
                Listener(
                  onPointerDown: (PointerDownEvent event) {
                    reply.setTapPosition(event.position);
                  },
                  child: GestureDetector(
                    onDoubleTap: () {
                      reply.handleDoubleTap();

                      if (reply.posts[index].upvoted == false) {
                        reply.posts[index].upvoted = true;
                        reply.posts[index].upvoteCount++;
                        reply.postLikeAdd(id: reply.posts[index].id);
                      }

                      Timer(Duration(seconds: 1), () => reply.isLiked = false);

                      if (reply.tapPosition != reply.prevTapPosition) {
                        reply.consecutiveDoubleTaps = 0;
                        reply.likeAnimationScale = 1.0;
                      }

                      reply.prevTapPosition = reply.tapPosition;

                      reply.consecutiveDoubleTaps++;
                      reply.likeAnimationScale =
                          1.0 + (reply.consecutiveDoubleTaps * 0.2);
                      reply.timer?.cancel();
                      reply.timer = Timer(
                        Duration(seconds: 2),
                        () {
                          reply.consecutiveDoubleTaps = 0;
                          reply.likeAnimationScale = 1.0;
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
                          return ReplyVideoSheet(
                            isUser:
                                reply.posts[index].username != prefs_username,
                            isFromFeed: true,
                            video_id: reply.posts[index].id,
                            category_name: '',
                            category_count: 0,
                            category_id: 0,
                            category_photo: '',
                            category_desc: '',
                            title: reply.posts[index].title,
                            video_link: reply.posts[index].videoLink,
                            current_index: index,
                          );
                        },
                      );
                    },
                    onTap: () {
                      if (reply.videoController(index)!.value.isPlaying) {
                        reply.isPlaying = false;
                        reply.videoController(index)!.pause();
                      } else {
                        reply.isPlaying = true;
                        reply.videoController(index)!.play();
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
                              CustomNetworkImage(
                                height: cs().height(context),
                                width: cs().width(context),
                                imageUrl: reply.posts[index].thumbnailUrl,
                                isLoading: true,
                              ),
                              if (isReplyInit) ...[
                                SizedBox.expand(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                        width: reply
                                            .videoController(index)!
                                            .value
                                            .size
                                            .width,
                                        height: reply
                                            .videoController(index)!
                                            .value
                                            .size
                                            .height,
                                        child: VideoPlayer(
                                            reply.videoController(index)!)),
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
                              video.isViewMode ? shrink : ReplyInfoSideBar(),
                              ReplyPlayButton(),
                              if (reply.isLiked) ...[
                                Positioned(
                                  left: reply.tapPosition.dx - 75,
                                  top: reply.tapPosition.dy - 150,
                                  child: SafeArea(
                                    child: Transform.scale(
                                      scale: reply.likeAnimationScale,
                                      child: Image.asset(
                                        AppAsset.like,
                                        color: Colors.white,
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              video.isViewMode ? shrink : ReplySideBar(),
                              ReplyVideoProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.09),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(220, 155, 166, 225),
                        Color.fromARGB(220, 155, 150, 151),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    home.posts[home.index].thumbnailUrl),
                                fit: BoxFit.cover),
                          ),
                          child: GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black26,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            onTap: () {
                              // pageController.jumpToPage(0);
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Response to: ',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 23, 23, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${home.posts[home.index].firstName}${home.posts[home.index].lastName}@${home.posts[home.index].username}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              height5,
                              Text(
                                home.posts[home.index].title,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 23, 23, 60),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class CustomBouncingScrollPhysics extends BouncingScrollPhysics {
  final double nFrictionFactor;

  CustomBouncingScrollPhysics(
      {ScrollPhysics? parent, this.nFrictionFactor = 0.001})
      : super(parent: parent);

  @override
  CustomBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomBouncingScrollPhysics(
      parent: buildParent(ancestor),
      nFrictionFactor: nFrictionFactor,
    );
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 60,
        damping: 1,
      );

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    final double friction = offset > 0.0 ? nFrictionFactor : nFrictionFactor;
    return super.applyPhysicsToUserOffset(position, offset) * friction;
  }
}
