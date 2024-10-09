import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/profile/shared/bio.dart';
import 'package:socialverse/features/profile/widgets/profile/shared/posts_grid.dart';
import 'package:socialverse/features/profile/widgets/profile/shared/profile_info.dart';
import 'package:socialverse/features/profile/widgets/profile/shared/profile_stats_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  late ScrollController _posts;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _posts = ScrollController();

    _posts.addListener(() {
      _profileScrollListener(_posts);
    });

    _controller.addListener(_tabChangedListener);
  }

  void _tabChangedListener() {
    if (_controller.index == 1) {
      final user = Provider.of<ProfileProvider>(context, listen: false);
      user.getUserLikedPosts();
    }
  }

  void _profileScrollListener(ScrollController controller) {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      final user = Provider.of<ProfileProvider>(context, listen: false);
      user.page++;
      print('position: ${controller.position.pixels}');
      if (_controller.index == 0) {
        user.getUserPosts(username: prefs_username!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            leading: shrink,
            leadingWidth: 10,
            centerTitle: false,
            title: Text(
              __.user.username,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
            surfaceTintColor: Colors.transparent,
            actions: [ProfileHeader()],
          ),
          body: RefreshIndicator(
            color: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).primaryColor,
            notificationPredicate: (notification) {
              return notification.depth == 2;
            },
            onRefresh: () async {
              __.page = 1;
              __.posts.clear();
              __.loading = true;
              await __.fetchProfile(
                  username: __.user.username, forceRefresh: true);
            },
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.depth != 2) {
                  if (!__.loading &&
                      scrollInfo is ScrollEndNotification &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    __.page++;
                    if (_controller.index == 0) {
                      __.getUserPosts(username: prefs_username!);
                    }
                    return true;
                  }
                }
                return false;
              },
              child: NestedScrollView(
                controller: _posts,
                headerSliverBuilder: (context, ___) {
                  return [
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          height10,
                          CustomCircularAvatar(
                            borderColor: Theme.of(context).hintColor,
                            height: 100,
                            width: 100,
                            imageUrl: __.user.profilePictureUrl,
                          ),
                          height10,
                          Text(
                            __.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 20),
                          ),
                          height10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ProfileStatsItem(
                                    value: __.user.followerCount,
                                    label: 'Followers',
                                    onTap: () {
                                      if (__.user.followerCount != 0) {
                                        Navigator.of(context).pushNamed(
                                          FollowersScreen.routeName,
                                          arguments: FollowersScreenArgs(
                                            username: __.user.username,
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              Expanded(
                                child: ProfileStatsItem(
                                  value: __.user.followingCount,
                                  label: 'Following',
                                  onTap: () {
                                    if (__.user.followingCount != 0) {
                                      Navigator.of(context).pushNamed(
                                        FollowingScreen.routeName,
                                        arguments: FollowingScreenArgs(
                                          username: __.user.username,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: ProfileStatsItem(
                                  value: __.user.postCount,
                                  label: 'Videos',
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          height20,
                          ProfileButton(),
                          height10,
                          Bio(bio: __.user.bio),
                          ProfileInfo(
                            instagram: __.user.instagramUrl,
                            tiktok: __.user.tiktokUrl,
                            youtube: __.user.youtubeUrl,
                            site: __.user.website,
                          ),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          controller: _controller,
                          labelStyle: AppTextStyle.bodyLarge
                              .copyWith(color: Constants.primaryColor),
                          labelColor: Constants.primaryColor,
                          unselectedLabelStyle: AppTextStyle.bodyLarge
                              .copyWith(color: Theme.of(context).focusColor),
                          unselectedLabelColor: Theme.of(context).focusColor,
                          indicatorColor: Theme.of(context).hintColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 2.5,
                          indicatorPadding: EdgeInsets.symmetric(vertical: 6),
                          dividerColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          tabs: [
                            Tab(text: 'Videos'),
                            Tab(text: 'Motions'),
                          ],
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _controller,
                  children: [
                    PostsGrid(
                      posts: __.posts,
                      isFromProfile: true,
                      likedTab: false,
                    ),
                    PostsGrid(
                      posts: __.likedPosts,
                      isFromProfile: true,
                      likedTab: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Theme.of(context).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
