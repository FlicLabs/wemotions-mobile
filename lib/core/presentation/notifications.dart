import 'package:socialverse/core/utils/extensions/date_extension.dart';
import 'package:socialverse/export.dart';

enum NotificationGroup { today, older }

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  Map<NotificationGroup, List<dynamic>> groupNotifications(
      List<dynamic> notifications) {
    final today = DateTime.now();
    return notifications.fold(<NotificationGroup, List<dynamic>>{
      NotificationGroup.today: [],
      NotificationGroup.older: [],
    }, (groups, notification) {
      final notificationDate = DateTime.parse(notification.createdAt);
      groups[notificationDate.year == today.year &&
                  notificationDate.month == today.month &&
                  notificationDate.day == today.day
              ? NotificationGroup.today
              : NotificationGroup.older]!
          .add(notification);
      return groups;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final home = Provider.of<HomeProvider>(context, listen: false);
    final user = Provider.of<UserProfileProvider>(context);
    final notification = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: shrink,
        leadingWidth: 10,
        centerTitle: false,
        title: Center(
          child: Text(
            notification.notifications.isNotEmpty ? 'Notifications' : "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (_, __, ___) {
          if (__.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SvgPicture.asset(
                      AppAsset.icnonotification,
                      height: 128,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  Text(
                    'No Notifications',
                    style: AppTextStyle.bodySmall.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'You don\'t have any notifications right now.\nKeep interacting and check back soon.',
                    style: AppTextStyle.bodySmall.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Group notifications by NotificationGroup
          final groupedNotifications = groupNotifications(__.notifications);

          return RefreshIndicator(
            color: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              __.notifications.clear();
              __.fetchActivity();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: NotificationGroup.values.map((group) {
                final groupTitle =
                    group == NotificationGroup.today ? "Today" : "Older";
                final notifications = groupedNotifications[group] ?? [];
                if (notifications.isEmpty) return SizedBox.shrink();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupTitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 10),
                    ...notifications.map((notification) {
                      return _buildNotificationTile(
                          context, notification, profile, home, user, __);
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context,
    dynamic notification,
    ProfileProvider profile,
    HomeProvider home,
    UserProfileProvider user,
    NotificationProvider notificationProvider,
  ) {
    Widget? trailingWidget;
    Widget? leadingWidget;

    switch (notification.actionType) {
      case 'follow':
        trailingWidget = null;
        break;

      case 'like':
        trailingWidget = GestureDetector(
          onTap: () async {
            home.single_post.clear();
            int postId = int.parse(notification.targetId!);
            await home.getSinglePost(id: postId);
            if (home.isPlaying == true) {
              await home.videoController(home.index)?.pause();
            }
            // Navigator.pushNamed(
            //   context,
            //   VideoWidget.routeName,
            //   arguments: VideoWidgetArgs(
            //     posts: home.single_post,
            //     pageController: PageController(initialPage: 0),
            //     pageIndex: 0,
            //   ),
            // );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CustomNetworkImage(
              imageUrl: notification.contentAvatarUrl,
              height: 48,
              width: 38,
            ),
          ),
        );
        break;

      case 'inspire':
        trailingWidget = GestureDetector(
          onTap: () async {
            home.single_post.clear();
            int postId = int.parse(notification.targetId!);
            await home.getSinglePost(id: postId);
            if (home.isPlaying == true) {
              await home.videoController(home.index)?.pause();
            }
            // Navigator.pushNamed(
            //   context,
            //   VideoWidget.routeName,
            //   arguments: VideoWidgetArgs(
            //     posts: home.single_post,
            //     pageController: PageController(initialPage: 0),
            //     pageIndex: 0,
            //   ),
            // );
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

    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 15),
      leading: leadingWidget,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: notification.actor.username,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: " ${notification.content}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
      trailing: trailingWidget,
    );
  }
}
