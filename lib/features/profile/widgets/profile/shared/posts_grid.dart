import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/profile/shared/post_grid_item.dart';
import 'package:socialverse/features/search/widgets/subverse_detail/subverse_post_grid_placeholder.dart';

class PostsGrid extends StatelessWidget {
  const PostsGrid({
    Key? key,
    required this.posts,
    required this.isFromProfile,
  }) : super(key: key);

  final List<Posts> posts;
  final bool isFromProfile;

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<UserProfileProvider>(context);
    bool isLoading = isFromProfile ? profile.loading : user.loading;
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: 1),
          sliver: isLoading == true
              ? SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: 12,
                  itemBuilder: (_, __) {
                    return SubversePostGridPlaceholder();
                  },
                )
              : SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.65,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return PostGridItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            VideoWidget.routeName,
                            arguments: VideoWidgetArgs(
                              posts: posts,
                              pageController:
                                  PageController(initialPage: index),
                              pageIndex: index,
                              isFromProfile: true,
                            ),
                          );
                        },
                        imageUrl: posts[index].thumbnailUrl,
                        createdAt: posts[index].createdAt,
                        viewCount: posts[index].viewCount,
                      );
                    },
                    childCount: posts.length,
                  ),
                ),
        ),
      ],
    );
  }
}
