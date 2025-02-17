import 'package:socialverse/export.dart';

class ReplySideBar extends StatelessWidget {
  const ReplySideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    final replyProvider = Provider.of<ReplyProvider>(context);
    final isAdmin = (prefsUsername == 'afrobeezy' || prefsUsername == 'jack');

    if (replyProvider.posts.isEmpty || replyProvider.index >= replyProvider.posts.length) {
      return shrink;
    }

    final post = replyProvider.posts[replyProvider.index];
    final isUser = post.username != prefsUsername;

    return Positioned(
      bottom: 140,
      right: 10,
      child: Container(
        height: cs().height(context),
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UpvoteButton(post: post, replyProvider: replyProvider),
              const SizedBox(height: 16),
              ShareButton(post: post, isUser: isUser),
              const SizedBox(height: 16),
              OptionsButton(post: post),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Extracted Widget: Upvote Button
class UpvoteButton extends StatelessWidget {
  final Post post;
  final ReplyProvider replyProvider;

  const UpvoteButton({Key? key, required this.post, required this.replyProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideBarItem(
      onTap: () {
        post.upvoted = !post.upvoted;
        post.upvoteCount += post.upvoted ? 1 : -1;

        if (post.upvoted) {
          replyProvider.postLikeAdd(id: post.id);
        } else {
          replyProvider.postLikeRemove(id: post.id);
        }
      },
      value: 14,
      icon: SvgPicture.asset(
        AppAsset.icwemotionslogo,
        color: post.upvoted ? const Color(0xFFA858F4) : Colors.white,
        fit: BoxFit.scaleDown,
      ),
      text: Text(
        post.upvoteCount.toString(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontFamily: 'sofia',
        ),
      ),
    );
  }
}

// Extracted Widget: Share Button
class ShareButton extends StatelessWidget {
  final Post post;
  final bool isUser;

  const ShareButton({Key? key, required this.post, required this.isUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideBarItem(
      onTap: () {
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
          builder: (context) => ShareSheet(isUser: isUser),
        );
      },
      value: 0,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgPicture.asset(
          AppAsset.icShare,
          color: Colors.white,
          fit: BoxFit.scaleDown,
        ),
      ),
      text: Text(
        post.shareCount.toString(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontFamily: 'sofia',
        ),
      ),
    );
  }
}

// Extracted Widget: Options Button
class OptionsButton extends StatelessWidget {
  final Post post;

  const OptionsButton({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SideBarItem(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          builder: (context) {
            return ReplyActionSheet(
              isUser: post.username != prefsUsername,
              isFromFeed: true,
              video_id: post.id,
              category_name: '',
              category_count: 0,
              category_id: 0,
              category_photo: '',
              category_desc: '',
              title: post.title,
              video_link: post.videoLink,
              current_index: post.id,
            );
          },
        );
      },
      value: 5,
      icon: SvgPicture.asset(
        AppAsset.icoptions,
        color: Colors.white,
        fit: BoxFit.scaleDown,
      ),
      text: shrink,
    );
  }
}

