import 'package:socialverse/export.dart';

class ReplyInfoSideBar extends StatelessWidget {
  const ReplyInfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = context.watch<VideoProvider>();
    final replyProvider = context.watch<ReplyProvider>();
    final post = replyProvider.posts[replyProvider.index];

    return Positioned(
      left: 15,
      bottom: video.downloading || video.downloadingCompleted ? 30 : 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _UserProfile(post: post),
          height10,
          if (post.title.trim().isNotEmpty)
            _PostTitle(replyProvider: replyProvider, postTitle: post.title),
        ],
      ),
    );
  }
}

class _UserProfile extends StatelessWidget {
  final Post post;
  const _UserProfile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: CachedNetworkImage(
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            fit: BoxFit.cover,
            height: 45,
            width: 45,
            imageUrl: post.pictureUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Image.asset(AppAsset.load, fit: BoxFit.cover),
            errorWidget: (context, url, error) => Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(AppAsset.icuser,
                  color: Theme.of(context).cardColor),
            ),
          ),
        ),
        width5,
        Text(post.username, style: AppTextStyle.normalRegular16),
      ],
    );
  }
}

class _PostTitle extends StatelessWidget {
  final ReplyProvider replyProvider;
  final String postTitle;

  const _PostTitle({required this.replyProvider, required this.postTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cs().width(context) - 100,
      child: GestureDetector(
        onTap: () => replyProvider.toggleTextExpanded(),
        child: Linkify(
          onOpen: (link) async {
            final url = Uri.parse(link.url);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $link';
            }
          },
          text: postTitle,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.normalRegular,
          textAlign: TextAlign.start,
          maxLines: replyProvider.isTextExpanded
              ? (5 + (6 * replyProvider.expansionProgress)).round()
              : 1,
          linkStyle: const TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

