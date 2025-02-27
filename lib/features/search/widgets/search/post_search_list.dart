import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialverse/export.dart';

import '../video/video_widget.dart';

class PostSearchList extends StatelessWidget {
  const PostSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        if (__.search.text.isNotEmpty && __.post_search.isEmpty) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: SvgPicture.asset(
                    AppAsset.search,
                    color: Constants.primaryGrey500,
                    width: cs.width(context)/2,
                    height: cs.height(context)/3,
                  ),
                ),

                Text(
                  "It seems we can't find the posts\n you're looking for. Try another\n search.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Constants.primaryGrey500,fontWeight: FontWeight.bold,fontSize: 20),
                )
              ],
            ),
          );
        }
        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 2),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            crossAxisSpacing: 6,
            mainAxisSpacing: 0,
          ),
          shrinkWrap: true,
          itemCount: __.post_search.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 10,
                  child: SubversePostGridItem(
                    onTap: () async {

                      await Navigator.pushNamed(
                        context,
                        VideoWidget.routeName,
                        arguments: VideoWidgetArgs(
                          posts: __.post_search,
                          pageController: PageController(initialPage: index),
                          pageIndex: index,
                        ),
                      );




                    },
                    imageUrl: __.post_search[index].thumbnailUrl,
                    createdAt: __.post_search[index].createdAt,
                    viewCount: __.post_search[index].viewCount,
                    username: __.post_search[index].username,
                    pictureUrl: __.post_search[index].pictureUrl,
                    isFromSearch: true,

                  ),
                ),
                height10,
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      __.post_search[index].title,
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCircularAvatar(
                              imageUrl: __.post_search[index].pictureUrl,
                              height: 14,
                              width: 14,
                            ),
                            width5,
                            Text(
                              __.post_search[index].username,
                              style: Theme.of(context).textTheme.displaySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAsset.icWemotionsLogo,
                              color: Colors.grey.shade500,
                              height: 11,
                              width: 11,
                            ),
                            width5,
                            Text(
                              '${__.post_search[index].upvoteCount}',
                              style: Theme.of(context).textTheme.labelSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
