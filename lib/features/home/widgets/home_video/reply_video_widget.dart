import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socialverse/core/domain/models/post_model.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/providers/reply_provider.dart';

import '../../utils/video_sheet.dart';
import 'last_page_gradient.dart';

class ReplyVideoWidget extends StatefulWidget {
  final Posts video;
  final PageController pageController;
  final int pIdx;
  final bool isLastPage;
  final int parentIdx;
  final bool isInit;
  const ReplyVideoWidget({
    super.key,
    required this.video,
    required this.pageController,
    required this.pIdx,
    required this.isLastPage,
    required this.parentIdx,
    required this.isInit,
  });

  @override
  State<ReplyVideoWidget> createState() => _ReplyVideoWidgetState();
}

class _ReplyVideoWidgetState extends State<ReplyVideoWidget> {
  // late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  /*Initializes video controller for the horizontal feed */
  initializeVideo() async {
    final reply = Provider.of<ReplyProvider>(context, listen: false);
    await reply.initializedVideoPlayer();
    reply.index = widget.pIdx;
  }

  @override
  /*Everything here on out is controlled through the reply provider including
  the horizontal video controllers ie reply.videoController()
  */
  Widget build(BuildContext context) {
    final reply = Provider.of<ReplyProvider>(context);
    final home = Provider.of<HomeProvider>(context);
    final video = Provider.of<VideoProvider>(context);
    return Stack(
      children: [
        PageView.builder(
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            reply.onPageChanged(value);
            reply.index = value;
          },
          itemCount: reply.posts.length,
          itemBuilder: (context, hindex) {
            bool isInit2 = reply.videoController(hindex)!.value.isInitialized;
            return GestureDetector(
              onDoubleTap: () {
                reply.handleDoubleTap();

                if (reply.posts[hindex].upvoted == false) {
                  reply.posts[hindex].upvoted = true;
                  reply.posts[hindex].upvoteCount++;
                  home.postLikeAdd(id: reply.posts[hindex].id);
                }

                Timer(Duration(seconds: 1), () => home.isLiked = false);

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
                    return VideoSheet(
                      isUser: reply.posts[hindex].username != prefs_username,
                      isFromFeed: true,
                      video_id: reply.posts[hindex].id,
                      category_name: '',
                      category_count: 0,
                      category_id: 0,
                      category_photo: '',
                      category_desc: '',
                      title: reply.posts[hindex].title,
                      video_link: reply.posts[hindex].videoLink,
                      current_index: widget.parentIdx,
                    );
                  },
                );
              },
              onTap: () {
                if (reply.videoController(hindex)!.value.isPlaying) {
                  reply.isPlaying = false;
                  reply.videoController(hindex)!.pause();
                } else {
                  reply.isPlaying = true;
                  reply.videoController(hindex)!.play();
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
                        if (!widget.isLastPage) ...[
                          CustomNetworkImage(
                            height: cs().height(context),
                            width: cs().width(context),
                            imageUrl: reply.posts[hindex].thumbnailUrl,
                            isLoading: true,
                          ),
                        ],
                        if (isInit2 && !widget.isLastPage) ...[
                          SizedBox.expand(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                  width: reply
                                      .videoController(hindex)!
                                      .value
                                      .size
                                      .width,
                                  height: reply
                                      .videoController(hindex)!
                                      .value
                                      .size
                                      .height,
                                  child: VideoPlayer(
                                      reply.videoController(hindex)!)),
                            ),
                          ),
                        ],
                        if (widget.isLastPage) ...[
                          LastPageGradient(
                            isInit: isInit2,
                            child: SizedBox(
                              width: reply
                                  .videoController(hindex)!
                                  .value
                                  .size
                                  .width,
                              height: reply
                                  .videoController(hindex)!
                                  .value
                                  .size
                                  .height,
                              child:
                                  VideoPlayer(reply.videoController(hindex)!),
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
                        if (!widget.isLastPage) ...[
                          video.isViewMode ? shrink : InfoSideBar(),
                        ],
                        if (!widget.isLastPage) PlayButton(),
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
                        if (!widget.isLastPage) ...[
                          video.isViewMode ? shrink : HomeSideBar(),
                        ],
                        HomeVideoProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            );

            // bool isInit = reply.videoController(hindex)!.value.isInitialized;
            // return VideoInterface(video: home.posts[index], indx: hindex);
            // return isInit
            //     ? VideoPlayer(
            //         reply.videoController(hindex)!,
            //       )
            //     : Container();
          },
        ),
      ],
    );
  }
}
