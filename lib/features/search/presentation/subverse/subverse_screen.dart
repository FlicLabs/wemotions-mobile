import 'package:socialverse/export.dart';
import 'package:socialverse/features/search/widgets/subverse/subverse_header.dart';
import 'package:socialverse/features/search/widgets/subverse_detail/subverse_post_grid_placeholder.dart';

class SubverseScreen extends StatelessWidget {
  const SubverseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            leading: shrink,
            leadingWidth: 10,
            centerTitle: false,
            title: PopupMenuButton<Sort>(
              color: Theme.of(context).primaryColor,
              elevation: 0,
              onSelected: (Sort selectedSort) {
                HapticFeedback.mediumImpact();
                __.sort = selectedSort;
              },
              itemBuilder: (BuildContext context) => Sort.values.map((sort) {
                return PopupMenuItem<Sort>(
                  value: sort,
                  child: Text(
                    __.sortName[sort] ?? 'Vible',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                );
              }).toList(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.list,
                    color: Theme.of(context).indicatorColor,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Theme.of(context).indicatorColor,
                  ),
                ],
              ),
            ),
            actions: [SubverseHeader()],
          ),
          body: RefreshIndicator(
            color: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              __.loading = true;
              __.posts_page = 1;
              await __.fetchCurrentSortedPosts;
            },
            child: Stack(
              children: [
                if (!__.loading) ...[
                  GridView.builder(
                    controller: __.controller,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: __.currentSortedPosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SubversePostGridItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            VideoWidget.routeName,
                            arguments: VideoWidgetArgs(
                              posts: __.currentSortedPosts,
                              pageController:
                                  PageController(initialPage: index),
                              pageIndex: index,
                              isFromSubverse: true,
                            ),
                          );
                        },
                        imageUrl: __.currentSortedPosts[index].thumbnailUrl,
                        createdAt: __.currentSortedPosts[index].createdAt,
                        viewCount: __.currentSortedPosts[index].viewCount,
                      );
                    },
                  ),
                ],
                if (__.loading) ...[
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: 12,
                    itemBuilder: (_, __) {
                      return SubversePostGridPlaceholder();
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
