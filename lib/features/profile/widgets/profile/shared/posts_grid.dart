import 'package:socialverse/export.dart';

class PostsGrid extends StatelessWidget {
  const PostsGrid({
    Key? key,
    required this.posts,
    required this.isFromProfile,
    required this.likedTab,
    this.isSelfProfile = true,
  }) : super(key: key);

  final List<Posts> posts;
  final bool isFromProfile;
  final bool likedTab;
  final bool isSelfProfile;

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
              : posts.length > 0
                  ? SliverGrid(
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
                              // Navigator.pushNamed(
                              //   context,
                              //   VideoWidget.routeName,
                              //   arguments: VideoWidgetArgs(
                              //     posts: posts,
                              //     pageController:
                              //         PageController(initialPage: index),
                              //     pageIndex: index,
                              //     isFromProfile: true,
                              //   ),
                              // );
                            },
                            imageUrl: posts[index].thumbnailUrl,
                            createdAt: posts[index].createdAt,
                            viewCount: posts[index].viewCount,
                            voteCount: posts[index].voting_count,
                          );
                        },
                        childCount: posts.length,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            height24,
                            Image.asset(
                              AppAsset.noVideos,
                            ),
                            height20,
                            Text(
                              likedTab ? 'No Liked Videos' : 'No Videos Yet',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.normalBold26.copyWith(
                                  color: Theme.of(context).focusColor),
                            ),
                            height20,
                            Container(
                              width: cs.width(context) * 0.7,
                              child: isSelfProfile
                                  ? Text(
                                      likedTab
                                          ? 'You currently have no liked videos'
                                          : 'Tap the plus button and create your first video',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.normalRegular16
                                          .copyWith(
                                              color:
                                                  Theme.of(context).focusColor),
                                      softWrap: true,
                                      maxLines: 2,
                                    )
                                  : Text(
                                      'This user has not posted any video yet',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.normalRegular16
                                          .copyWith(
                                              color:
                                                  Theme.of(context).focusColor),
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
        ),
      ],
    );
  }
}
