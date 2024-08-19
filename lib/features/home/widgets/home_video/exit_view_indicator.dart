import 'package:socialverse/export.dart';

class ExitView extends StatelessWidget {
  const ExitView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final video = Provider.of<VideoProvider>(context);
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return __.posts.isEmpty
            ? shrink
            : Container(
                height: cs().height(context),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Column(
                              children: [
                                SideBarItem(
                                  onTap: () {
                                    if (video.isViewMode) {
                                      video.isViewMode = false;
                                    } else {
                                      video.isViewMode = true;
                                    }
                                  },
                                  value: 5,
                                  icon: Icon(
                                    Icons.fullscreen_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  text: shrink,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: video.downloading == true ||
                                    video.downloadingCompleted
                                ? cs().height(context) * 0.20
                                : cs().height(context) * 0.18,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
