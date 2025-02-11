import 'package:socialverse/export.dart';

class UserProfileScreenArgs {
  final String username;
  final Function(bool isFollowing)? isFollowing;

  const UserProfileScreenArgs({
    required this.username,
    this.isFollowing,
  });
}

class UserProfileScreen extends StatefulWidget {
  static const String routeName = '/user';
  const UserProfileScreen({
    Key? key,
    required this.username,
    this.isFollowing,
  }) : super(key: key);

  final String username;
  final Function(bool isFollow)? isFollowing;

  static Route route({required UserProfileScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UserProfileScreen(
        username: args.username,
        isFollowing: args.isFollowing,
      ),
    );
  }

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  late ScrollController _postsController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
    _postsController = ScrollController();
    _postsController.addListener(_onScroll);
    _controller.addListener(_onTabChange);

    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
    userProvider.page = 1;
    userProvider.posts.clear();

    await userProvider.getUserProfile(username: widget.username);

    if (widget.username != prefs_username) {
      userProvider.isFollowing = userProvider.user.isFollowing;
      userProvider.isBlocked = userProvider.user.isBlocked;
    }

    await userProvider.getUserPosts(username: widget.username);

    // Defer the state update to the next frame
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  void _onTabChange() {
    if (_controller.index == 1) {
      _postsController.jumpTo(0);
    }
  }

  void _onScroll() {
    if (_postsController.position.pixels == _postsController.position.maxScrollExtent) {
      final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
      if (!userProvider.loading) {
        // Defer the state update to the next frame
        SchedulerBinding.instance.addPostFrameCallback((_) {
          userProvider.getUserPosts(username: widget.username);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<UserProfileProvider>(
          builder: (context, userProvider, child) {
            return Text(
              userProvider.user.username,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            );
          },
        ),
        surfaceTintColor: Colors.transparent,
        actions: [
          Consumer<UserProfileProvider>(
            builder: (context, userProvider, child) {
              return UserProfileHeader(username: userProvider.user.username);
            },
          ),
        ],
      ),
      body: Consumer<UserProfileProvider>(
        builder: (context, userProvider, child) {
          if (_isLoading && userProvider.posts.isEmpty) {
            return Center(child: CustomProgressIndicator());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!userProvider.loading &&
                  scrollInfo is ScrollEndNotification &&
                  scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                userProvider.getUserPosts(username: widget.username);
                return true;
              }
              return false;
            },
            child: RefreshIndicator(
              color: Theme.of(context).indicatorColor,
              backgroundColor: Theme.of(context).primaryColor,
              notificationPredicate: (notification) => notification.depth == 2,
              onRefresh: () async {
                final userProvider = Provider.of<UserProfileProvider>(context, listen: false);
                userProvider.page = 1;
                userProvider.posts.clear();
                userProvider.loading = true;

                await userProvider.getUserProfile(username: widget.username, forceRefresh: true);
                await userProvider.getUserPosts(username: widget.username);
                // Defer the state update to the next frame
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {});
                  }
                });
              },
              child: NestedScrollView(
                controller: _postsController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
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
                            imageUrl: userProvider.user.profilePictureUrl,
                          ),
                          height10,
                          Text(
                            userProvider.user.name,
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
                                  value: userProvider.user.followerCount,
                                  label: 'Followers',
                                  onTap: () {
                                    if (userProvider.user.followerCount != 0) {
                                      Navigator.of(context).pushNamed(
                                        FollowersScreen.routeName,
                                        arguments: FollowersScreenArgs(
                                          username: userProvider.user.username,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: ProfileStatsItem(
                                  value: userProvider.user.followingCount,
                                  label: 'Following',
                                  onTap: () {
                                    if (userProvider.user.followingCount != 0) {
                                      Navigator.of(context).pushNamed(
                                        FollowingScreen.routeName,
                                        arguments: FollowingScreenArgs(
                                          username: userProvider.user.username,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: ProfileStatsItem(
                                  value: userProvider.user.postCount,
                                  label: 'Videos',
                                ),
                              ),
                            ],
                          ),
                          height20,
                          UserProfileButton(
                            isFollowing: widget.isFollowing,
                            username: userProvider.user.username,
                            chat_id: userProvider.user.chatId,
                          ),
                          Bio(bio: userProvider.user.bio),
                          ProfileInfo(
                            instagram: userProvider.user.instagramUrl,
                            tiktok: userProvider.user.tiktokUrl,
                            youtube: userProvider.user.youtubeUrl,
                            site: userProvider.user.website,
                          ),
                          height20,
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          controller: _controller,
                          labelStyle: AppTextStyle.bodyLarge
                              .copyWith(color: Color(0xFF9032E6)),
                          labelColor: Color(0xFF9032E6),
                          unselectedLabelStyle: AppTextStyle.bodyLarge
                              .copyWith(color: Theme.of(context).focusColor),
                          unselectedLabelColor: Theme.of(context).focusColor,
                          indicatorColor: Color(0xFF9032E6),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 2.5,
                          indicatorPadding: EdgeInsets.symmetric(vertical: 6),
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(text: 'Videos'),
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
                      posts: userProvider.posts,
                      isFromProfile: false,
                      likedTab: false,
                      isSelfProfile: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _postsController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}