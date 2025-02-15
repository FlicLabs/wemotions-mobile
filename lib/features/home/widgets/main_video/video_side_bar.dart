import 'package:socialverse/export.dart';

class VideoSideBar extends StatelessWidget {
  const VideoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context, listen: false);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    bool isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    return Selector<VideoProvider, int>(
      selector: (_, provider) => provider.index,
      builder: (_, index, __) {
        final videoProvider = Provider.of<VideoProvider>(context, listen: false);
        
        // Ensure posts are not empty and index is valid
        if (videoProvider.posts.isEmpty || index >= videoProvider.posts.length) {
          return const SizedBox.shrink();
        }

        final post = videoProvider.posts[index];

        return Positioned(
          bottom: 0,
          right: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLikeButton(post, videoProvider, home, auth),
              height7,
              _buildCommentButton(post, context),
              height7,
              _buildShareButton(post, context),
              height7,
              _buildViewToggleButton(videoProvider),
              height7,
              if (isAdmin) _buildAdminExitCounter(post, videoProvider),
              SizedBox(
                height: (videoProvider.downloading || videoProvider.downloadingCompleted)
                    ? cs().height(context) * 0.1
                    : cs().height(context) * 0.08,
              ),
            ],
          ),
        );
      },
    );
  }

  // Like Button
  Widget _buildLikeButton(Post post, VideoProvider videoProvider, HomeProvider home, AuthProvider auth) {
    return SideBarItem(
      onTap: () {
        if (logged_in) {
          post.upvoted = !post.upvoted;
          post.upvoteCount += post.upvoted ? 1 : -1;

          post.upvoted
              ? home.postLikeAdd(id: post.id)
              : home.postLikeRemove(id: post.id);
        } else {
          auth.showAuthBottomSheet(auth.context);
        }
      },
      value: 14,
      icon: ShaderMask(
        shaderCallback: (Rect bounds) {
          return (post.upvoted
                  ? LinearGradient(
                      colors: [Theme.of(auth.context).hintColor, Colors.pink, Theme.of(auth.context).hintColor],
                    )
                  : const LinearGradient(colors: [Colors.white, Colors.white]))
              .createShader(bounds);
        },
        child: SvgPicture.asset(AppAsset.iclike, color: Colors.white),
      ),
      text: shrink,
    );
  }

  // Comment Button
  Widget _buildCommentButton(Post post, BuildContext context) {
    return SideBarItem(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          builder: (context) => FractionallySizedBox(
            heightFactor: 1,
            child: HomeCommentWidget(id: post.id),
          ),
        );
      },
      value: 14,
      icon: SvgPicture.asset(AppAsset.iccomment, color: Colors.white),
      text: shrink,
    );
  }

  // Share Button
  Widget _buildShareButton(Post post, BuildContext context) {
    return SideBarItem(
      onTap: () {
        HapticFeedback.mediumImpact();
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          ),
          builder: (context) => ShareSheet(
            isUser: post.username != prefs_username,
            dynamicLink: 'link',
          ),
        );
      },
      value: 0,
      icon: Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: Icon(UniconsLine.share, color: Colors.white, size: 22),
      ),
      text: shrink,
    );
  }

  // View Mode Toggle Button
  Widget _buildViewToggleButton(VideoProvider videoProvider) {
    return SideBarItem(
      onTap: () {
        HapticFeedback.mediumImpact();
        videoProvider.isViewMode = !videoProvider.isViewMode;
      },
      value: 5,
      icon: Icon(Icons.fullscreen_rounded, color: Colors.white, size: 25),
      text: shrink,
    );
  }

  // Admin Exit Counter
  Widget _buildAdminExitCounter(Post post, VideoProvider videoProvider) {
    return SideBarItem(
      onTap: () {
        HapticFeedback.lightImpact();
        post.exitCount += 1;
        videoProvider.updateExitCount(id: post.id);
      },
      value: 5,
      icon: Center(
        child: Text(
          '${post.exitCount}',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'sofia'),
        ),
      ),
      text: shrink,
    );
  }
}

