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
      final notificationDate = DateTime.tryParse(notification.createdAt) ??
          DateTime.fromMillisecondsSinceEpoch(0);
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
    final profile = context.watch<ProfileProvider>();
    final home = context.read<HomeProvider>();
    final user = context.watch<UserProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(), // Replace `shrink` with SizedBox
        leadingWidth: 10,
        centerTitle: false,
        title: Consumer<NotificationProvider>(
          builder: (_, notification, __) => Center(
            child: Text(
              notification.notifications.isNotEmpty ? 'Notifications' : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
      body: Selector<NotificationProvider, List<dynamic>>(
        selector: (_, provider) => provider.notifications,
        builder: (context, notifications, child) {
          if (notifications.isEmpty) {
            return _buildEmptyNotificationState();
          }

          final groupedNotifications = groupNotifications(notifications);

          return RefreshIndicator(
            color: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () => context.read<NotificationProvider>().fetchActivity(),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: NotificationGroup.values.expand((group) {
                final groupTitle = group == NotificationGroup.today ? "Today" : "Older";
                final groupItems = groupedNotifications[group] ?? [];

                if (groupItems.isEmpty) return [];

                return [
                  Text(
                    groupTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  ...groupItems.map((notification) =>
                      _buildNotificationTile(context, notification, profile, home, user)),
                ];
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyNotificationState() {
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
              color: const Color(0xFF7C7C7C),
            ),
          ),
          const Text(
            'No Notifications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          const Text(
            'You don\'t have any notifications right now.\nKeep interacting and check back soon.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context,
    dynamic notification,
    ProfileProvider profile,
    HomeProvider home,
    UserProfileProvider user,
  ) {
    final actionType = notification.actionType;
    final notificationImage = notification.contentAvatarUrl ?? "";
    final notificationActor = notification.actor;
    
    Widget? trailingWidget;

    if (actionType == 'like' || actionType == 'inspire') {
      trailingWidget = GestureDetector(
        onTap: () => _handleNotificationTap(context, home, notification),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CustomNetworkImage(
            imageUrl: notificationImage,
            height: 48,
            width: 38,
          ),
        ),
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 15),
      leading: GestureDetector(
        onTap: () {
          user.page = 1;
          user.posts.clear();
          user.user = ProfileModel.empty;
          Navigator.of(context).pushNamed(
            UserProfileScreen.routeName,
            arguments: UserProfileScreenArgs(
              username: notificationActor.username,
              isFollowing: (following) => notificationActor.isFollowing = following,
            ),
          );
        },
        child: CustomCircularAvatar(
          height: 50,
          width: 50,
          imageUrl: notificationActor.profileUrl,
        ),
      ),
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: notificationActor.username,
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

  void _handleNotificationTap(BuildContext context, HomeProvider home, dynamic notification) async {
    home.single_post.clear();
    final postId = int.tryParse(notification.targetId ?? '0') ?? 0;

    if (postId > 0) {
      await home.getSinglePost(id: postId);

      if (home.isPlaying) {
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
    }
  }
}
