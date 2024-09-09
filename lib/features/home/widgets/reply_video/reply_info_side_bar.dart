import 'package:socialverse/export.dart';

class ReplyInfoSideBar extends StatelessWidget {
  const ReplyInfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    return Consumer<ReplyProvider>(
      builder: (_, __, ___) {
        final postTitle = __.posts[__.index].title;
        return Positioned(
          left: 15,
          bottom:
              video.downloading == true || video.downloadingCompleted ? 30 : 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (__.posts[__.index].title.isNotEmpty) ...[
                SizedBox(
                  width: cs().width(context) - 100,
                  child: GestureDetector(
                    onTap: () => __.toggleTextExpanded(),
                    child: Linkify(
                      onOpen: (link) async {
                        if (await canLaunchUrl(Uri.parse(link.url))) {
                          await launchUrl(Uri.parse(link.url));
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: postTitle,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.normalRegular,
                      textAlign: TextAlign.start,
                      maxLines: __.isTextExpanded
                          ? (5 + (6 * __.expansionProgress)).round()
                          : 1,
                      linkStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
