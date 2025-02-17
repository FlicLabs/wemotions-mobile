import 'package:socialverse/export.dart';

class PostSearchList extends StatelessWidget {
  const PostSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SearchProvider, List<Post>>(
      selector: (_, provider) => provider.post_search,
      builder: (context, postSearchList, _) {
        if (postSearchList.isEmpty) {
          return const _NoResultsWidget();
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: postSearchList.length,
          itemBuilder: (context, index) {
            return PostItem(post: postSearchList[index], index: index);
          },
        );
      },
    );
  }
}

/// Extracted No Results Widget
class _NoResultsWidget extends StatelessWidget {
  const _NoResultsWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 200,
            color: Theme.of(context).indicatorColor,
          ),
          const SizedBox(height: 16),
          Text(
            "It seems we can't find the user\n you're looking for. Try another\n search.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

/// Extracted Post Item Widget
class PostItem extends StatelessWidget {
  final Post post;
  final int index;

  const PostItem({Key? key, required this.post, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  posts: [post],
                  pageController: PageController(initialPage: index),
                  pageIndex: index,
                ),
              );
            },
            imageUrl: post.thumbnailUrl ?? '',
            createdAt: post.createdAt ?? '',
            viewCount: post.viewCount ?? 0,
            username: post.username ?? 'Unknown',
            pictureUrl: post.pictureUrl ?? '',
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          flex: 1,
          child: Text(
            post.title ?? 'No Title',
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomCircularAvatar(
                    imageUrl: post.pictureUrl ?? '',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    post.username ?? 'Unknown',
                    style: Theme.of(context).textTheme.displaySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: Theme.of(context).iconTheme.size ?? 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${post.upvoteCount ?? 0}',
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

