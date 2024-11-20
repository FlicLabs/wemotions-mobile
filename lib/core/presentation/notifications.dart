import 'package:socialverse/core/utils/extensions/date_extension.dart';
import 'package:socialverse/export.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final home = Provider.of<HomeProvider>(context, listen: false);
    final user = Provider.of<UserProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: shrink,
        leadingWidth: 10,
        centerTitle: false,
        title: Text(
          'Activity',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (_, __, ___) {
          if (__.notifications.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  'No activity',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.start,
                ),
              ),
            );
          }
          return RefreshIndicator(
            color: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              __.notifications.clear();
              __.fetchActivity();
            },
            child: ListView.builder(
              //shrinkWrap: true,
              itemCount: __.notifications.length,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) {
                final notification = __.notifications[index];
                Widget? trailingWidget;
                Widget? leadingWidget;
                switch (notification.actionType) {
                  case 'follow':
                    if (notification.actor.isFollowing == false) {
                      trailingWidget = TransparentButton(
                        title: 'Subscribe',
                        height: 35,
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFA858F4),
                              Color(0xFF9032E6),
                            ],
                            stops: [
                              0.0,
                              1.0
                            ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            tileMode: TileMode.repeated),
                        width: 100,
                        onTap: () {
                          __.toggleFollowing(index);
                          profile.userFollow(
                              username: notification.actor.username);
                        },
                      );
                    } else {
                      trailingWidget = TransparentButton(
                        title: 'Unsubscribe',
                        height: 35,
                        width: 100,
                        onTap: () {
                          __.toggleFollowing(index);
                          profile.userUnfollow(
                              username: notification.actor.username);
                        },
                      );
                    }
                    break;
                  case 'like':
                  case 'comment':
                  case 'login_bonus':
                    trailingWidget = Text(
                      formatDate(notification.createdAt),
                      style: Theme.of(context).textTheme.displaySmall,
                    );
                    break;
                  case 'inspire':
                    trailingWidget = GestureDetector(
                      onTap: () async {
                        home.single_post.clear();
                        int post_id = int.parse(notification.targetId!);
                        await home.getSinglePost(id: post_id);
                        if (home.isPlaying == true) {
                          await home.videoController(home.index)?.pause();
                        }
                        Navigator.pushNamed(
                          context,
                          VideoWidget.routeName,
                          arguments: VideoWidgetArgs(
                            posts: home.single_post,
                            pageController: PageController(initialPage: 0),
                            pageIndex: 0,
                          ),
                        );
                      },
                      child: CustomNetworkImage(
                        imageUrl: notification.contentAvatarUrl,
                        height: 50,
                        width: 50,
                      ),
                    );
                    break;
                  default:
                    trailingWidget = null;
                    break;
                }

                switch (notification.actionType) {
                  case 'login_bonus':
                    leadingWidget = GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse('https://holyvible.page.link/108'),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: CustomCircularAvatar(
                        height: 50,
                        width: 50,
                        imageUrl: notification.contentAvatarUrl,
                        borderColor: Colors.grey.withOpacity(0.4),
                      ),
                    );
                    break;
                  default:
                    leadingWidget = GestureDetector(
                      onTap: () {
                        user.page = 1;
                        user.posts.clear();
                        user.user = ProfileModel.empty;
                        Navigator.of(context).pushNamed(
                          UserProfileScreen.routeName,
                          arguments: UserProfileScreenArgs(
                            username: notification.actor.username,
                            isFollowing: (following) {
                              notification.actor.isFollowing = following;
                            },
                          ),
                        );
                      },
                      child: CustomCircularAvatar(
                        height: 50,
                        width: 50,
                        imageUrl: notification.actor.profileUrl,
                      ),
                    );
                    break;
                }

                return ListTile(
                  contentPadding: EdgeInsets.only(bottom: 20),
                  leading: leadingWidget,
                  title: notification.actionType == 'login_bonus'
                      ? Text(
                          "you ${notification.content}",
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : notification.actionType == 'token_transfer'
                          ? Text(
                              "you ${notification.content}",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          : Text(
                              notification.actor.username,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                  subtitle: notification.actionType == 'token_transfer' ||
                          notification.actionType == 'login_bonus'
                      ? null
                      : Text(
                          notification.content,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                  trailing: trailingWidget,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
