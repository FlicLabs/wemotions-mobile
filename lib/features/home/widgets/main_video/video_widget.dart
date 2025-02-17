import 'package:socialverse/export.dart';

class VideoWidgetArgs {
  final dynamic posts;
  final PageController pageController;
  final int pageIndex;
  final bool? isFromProfile;
  final bool? isFromSubverse;

  const VideoWidgetArgs({
    required this.posts,
    required this.pageController,
    required this.pageIndex,
    this.isFromProfile,
    this.isFromSubverse,
  });
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
  late VideoProvider _video;
  late HomeProvider _home;
  late CommentProvider _comment;
  late ExitProvider _exit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeVideo());
  }

  void _initializeVideo() {
    _video = Provider.of<VideoProvider>(context, listen: false);
    _video.index = widget.pageIndex;
    _video.initController(widget.pageIndex, widget.posts);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _video = Provider.of<VideoProvider>(context);
    _home = Provider.of<HomeProvider>(context);
    _comment = Provider.of<CommentProvider>(context);
    _exit = Provider.of<ExitProvider>(context);
  }

  @override
  void dispose() {
    _video.videoControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    bool isInit = _video.videoController(_video.index)?.value.isInitialized ?? false;

    return GestureDetector(
      onHorizontalDragStart: (_) {
        if (!_exit.isInit) {
          _comment.comment.clear();
          _comment.focusNode.unfocus();
          Navigator.of(context).pop(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              itemCount: widget.posts.length,
              controller: widget.pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) => _onPageChanged(index),
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onDoubleTap: () => _handleDoubleTap(index),
                  onTap: () => _toggleVideoPlayPause(index),
                  child: Stack(
                    children: [
                      _buildVideoBackground(index, isInit),
                      _buildVideoOverlay(),
                      _buildLikeAnimation(),
                      BottomCommentBar(isKeyboardShowing: isKeyboardShowing),
                      _buildTopAppBar(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    if (index > _video.index) {
      _video.nextVideo();
    } else if (index < _video.index) {
      _video.previousVideo();
    }
    _video.index = index;
    _video.isFollowing = _video.posts[index].following;
  }

  void _toggleVideoPlayPause(int index) {
    final controller = _video.videoController(index);
    if (controller != null && controller.value.isInitialized) {
      if (controller.value.isPlaying) {
        _video.isPlaying = false;
        controller.pause();
      } else {
        _video.isPlaying = true;
        controller.play();
      }
    }
  }

  void _handleDoubleTap(int index) {
    _home.handleDoubleTap();
    if (!_video.posts[index].upvoted) {
      _video.posts[index].upvoted = true;
      _video.posts[index].upvoteCount++;
      _home.postLikeAdd(id: _video.posts[index].id);
    }
    Timer(Duration(seconds: 1), () => _home.isLiked = false);
  }

  Widget _buildVideoBackground(int index, bool isInit) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomNetworkImage(
            height: double.infinity,
            width: double.infinity,
            imageUrl: _video.posts[index].thumbnailUrl,
            fit: BoxFit.cover,
          ),
          if (isInit) VideoPlayer(_video.videoController(index)!),
        ],
      ),
    );
  }

  Widget _buildVideoOverlay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
      ),
    );
  }

  Widget _buildLikeAnimation() {
    return Positioned(
      left: _home.tapPosition.dx - 75,
      top: _home.tapPosition.dy - 150,
      child: AnimatedScale(
        scale: _home.likeAnimationScale,
        duration: Duration(milliseconds: 300),
        child: Image.asset(AppAsset.like, color: Colors.white, height: 150),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}


