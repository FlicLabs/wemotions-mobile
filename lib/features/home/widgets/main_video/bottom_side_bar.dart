import 'package:socialverse/export.dart';

class BottomSideBar extends StatelessWidget {
  const BottomSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final videoProvider = Provider.of<VideoProvider>(context);
    final post = videoProvider.posts[videoProvider.index];
    final isAdmin = (prefs_username == 'afrobeezy' || prefs_username == 'jack');

    void _handleLike() {
      if (logged_in) {
        post.upvoted ? post.upvoteCount-- : post.upvoteCount++;
        post.upvoted = !post.upvoted;
        post.upvoted ? home.postLikeAdd(id: post.id) : home.postLikeRemove(id: post.id);
      } else {
        auth.showAuthBottomSheet(context);
      }
    }

    void _handleShare() {
      HapticFeedback.mediumImpact();
      final isUser = post.username != prefs_username;
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (context) => ShareSheet(isUser: isUser, dynamicLink: 'link'),
      );
    }

    void _handleInspired() async {
      HapticFeedback.heavyImpact();
      if (videoProvider.videoController(videoProvider.index)!.value.isPlaying) {
        await videoProvider.videoController(videoProvider.index)!.pause();
      }
      home.showInspiredDialog(context, id: post.id);
    }

    void _handleExitCount() {
      HapticFeedback.lightImpact();
      post.exitCount++;
      videoProvider.updateExitCount(id: post.id);
    }

    return Positioned(
      bottom: 0,
      child: Container(
        width: cs().width(context),
        height: cs().height(context) * 0.1,
        color: Colors.grey.shade900,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SideBarItem(
                onTap: _handleLike,
                value: post.upvoteCount,
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: post.upvoted ? [Theme.of(context).hintColor, Colors.pink] : [Colors.white, Colors.white],
                    ).createShader(bounds);
                  },
                  child: SvgPicture.asset(AppAsset.iclike, color: Colors.white),
                ),
              ),
              SideBarItem(
                onTap: _handleShare,
                value: 0,
                icon: const Icon(UniconsLine.share, color: Colors.white, size: 22),
              ),
              SideBarItem(
                onTap: _handleInspired,
                value: 10,
                icon: Image.asset(AppAsset.icon),
              ),
              if (isAdmin)
                SideBarItem(
                  onTap: _handleExitCount,
                  value: post.exitCount,
                  icon: Text(
                    '${post.exitCount}',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white, fontFamily: 'sofia'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

