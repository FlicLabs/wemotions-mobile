import 'package:socialverse/export.dart';

class PostSearchList extends StatelessWidget {
  const PostSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
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
                    onTap: () {
                      Navigator.pushNamed(
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

                  ),
                ),
                height10,
                Expanded(
                  flex: 1,
                  child: Text(
                    __.post_search[index].title,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCircularAvatar(
                            imageUrl: __.post_search[index].pictureUrl,
                            height: 10,
                            width: 10,
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
                          Icon(
                            Icons.favorite_border,
                            size: 11,
                            color: Colors.grey.shade500,
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
                )
              ],
            );
          },
        );
      },
    );
  }
}
