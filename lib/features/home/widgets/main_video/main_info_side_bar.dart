import 'package:socialverse/export.dart';

class MainInfoSideBar extends StatelessWidget {
  const MainInfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (_, videoProvider, __) {
        final post = videoProvider.posts[videoProvider.index];
        final double bottomPadding = (videoProvider.downloading || videoProvider.downloadingCompleted)
            ? cs().height(context) * 0.04
            : cs().height(context) * 0.02;

        return Positioned(
          left: 15,
          bottom: bottomPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (post.title.isNotEmpty)
                SizedBox(
                  width: cs().width(context) - 100,
                  child: GestureDetector(
                    onTap: () => videoProvider.toggleTextExpanded(),
                    child: Linkify(
                      onOpen: (link) async {
                        try {
                          if (await canLaunchUrl(Uri.parse(link.url))) {
                            await launchUrl(Uri.parse(link.url));
                          } else {
                            throw 'Could not launch ${link.url}';
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      text: post.title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.normalRegular,
                      textAlign: TextAlign.start,
                      maxLines: videoProvider.isTextExpanded
                          ? (5 + (6 * videoProvider.expansionProgress)).round()
                          : 1,
                      linkStyle: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
