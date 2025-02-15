import 'dart:ui';

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
  late ReplyProvider _reply;

  @override
  void initState() {
    super.initState();
    _reply = context.read<ReplyProvider>();
    _reply.initializedVideoPlayer();
    _reply.index = widget.postIndex;
  }

  @override
  void dispose() {
    for (var controller in _reply.controllers.values) {
      controller.dispose();
    }
    _reply.controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reply = context.watch<ReplyProvider>();
    final home = context.watch<HomeProvider>();
    final video = context.watch<VideoProvider>();

    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: widget.pageController,
          physics: const BouncingScrollPhysics(),
          itemCount: reply.posts.length,
          onPageChanged: (index) {
            home.horizontalIndex = index + 1;
            reply.onPageChanged(index);
            reply.index = index;
            reply.isFollowing = reply.posts[index].following;
          },
          itemBuilder: (context, index) {
            final post = reply.posts[index];
            final controller = reply.videoController(index);
            final isReplyInit = controller?.value.isInitialized ?? false;

            return GestureDetector(
              onDoubleTap: () {
                if (!post.upvoted) {
                  post.upvoted = true;
                  post.upvoteCount++;
                  reply.postLikeAdd(id: post.id);
                }
                reply.triggerLikeAnimation();
              },
              onTap: () {
                if (controller?.value.isPlaying ?? false) {
                  controller?.pause();
                  reply.isPlaying = false;
                } else {
                  controller?.play();
                  reply.isPlaying = true;
                }
              },
              child: Stack(
                children: [
                  _buildVideoBackground(context, reply, index, isReplyInit),
                  if (video.downloading) DownloadBar(color: Colors.grey.withOpacity(0.4), label: 'Saving: ${video.progressString}'),
                  if (video.downloadingCompleted) DownloadBar(color: Theme.of(context).hintColor, label: 'Video Saved'),
                  if (!video.isViewMode) ReplyInfoSideBar(),
                  if (!video.isViewMode) ReplySideBar(),
                  ReplyPlayButton(),
                  ReplyVideoProgressIndicator(),
                  if (reply.isLiked) _buildLikeAnimation(reply),
                  _buildReplyOverlay(context, home),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVideoBackground(BuildContext context, ReplyProvider reply, int index, bool isReplyInit) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomNetworkImage(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            imageUrl: reply.posts[index].thumbnailUrl,
            isLoading: true,
          ),
          if (isReplyInit)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: reply.videoController(index)!.value.size.width,
                  height: reply.videoController(index)!.value.size.height,
                  child: VideoPlayer(reply.videoController(index)!),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLikeAnimation(ReplyProvider reply) {
    return Positioned(
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
    );
  }

  Widget _buildReplyOverlay(BuildContext context, HomeProvider home) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.09,
        left: MediaQuery.of(context).size.width * 0.15,
        right: MediaQuery.of(context).size.width * 0.15,
      ),
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildReplyUserInfo(context, home),
                _buildReplyThumbnail(home),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReplyUserInfo(BuildContext context, HomeProvider home) {
    return Flexible(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Replying to', style: AppTextStyle.normalRegular16),
            height20,
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: CachedNetworkImage(
                    height: 35,
                    width: 35,
                    imageUrl: home.posts[home.index][0].pictureUrl,
                    errorWidget: (context, url, error) => _buildUserIcon(context),
                  ),
                ),
                width5,
                Text(home.posts[home.index][0].username, style: AppTextStyle.normalRegular14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyThumbnail(HomeProvider home) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: CachedNetworkImageProvider(home.posts[home.index][0].thumbnailUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black26,
            ),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }

  Widget _buildUserIcon(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(8),
      child: SvgPicture.asset(AppAsset.icuser, color: Theme.of(context).cardColor),
    );
  }
}
