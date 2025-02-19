import 'package:socialverse/export.dart';

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({
    Key? key,
    required this.username,
    required this.isFollowing,
    this.chat_id,
  }) : super(key: key);

  final String username;
  final Function(bool isFollowing)? isFollowing;
  final int? chat_id;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final notification = getIt<NotificationProvider>();
    return Consumer<UserProfileProvider>(
      builder: (_, __, ___) {
        return Column(
          children: [
            if (username != prefs_username) ...[
              if (!__.isBlocked) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                  ),
                  child: SizedBox(
                    width: 177,
                    child: __.isFollowing == true
                        ? CustomTransparentButton(
                            borderColor: Color(0xFF9032E6),
                            textColor: Color(0xFF9032E6),
                            title: 'Following',
                            // textColor: Theme.of(context).indicatorColor,
                            color: Theme.of(context).canvasColor,
                            onTap: () {
                              if (logged_in == true) {
                                if (isFollowing != null) {
                                  isFollowing!(false);
                                }
                                __.isFollowing = false;
                                __.userUnfollow(
                                  username: username,
                                );
                                // notification.deleteActivity(notificationId: notification.notifications.where((notification) => (notification.actor.username==prefs_username) && notification.user.username==username).first.id);

                              } else {
                                auth.showAuthBottomSheet(context);
                              }
                            },
                          )
                        : TransparentButton(
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xFFA858F4),
                                  Color(0xFF9032E6),
                                ],
                                stops: [0.0, 1.0],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                tileMode: TileMode.repeated,
                            ) ,
                            textColor: Constants.lightPrimary,
                            title: 'Follow',
                            onTap: () {
                              if (logged_in == true) {
                                if (isFollowing != null) {
                                  isFollowing!(true);
                                }
                                __.isFollowing = true;
                                __.userFollow(
                                  username: username,
                                );
                              } else {
                                auth.showAuthBottomSheet(context);
                              }
                            },
                          ),
                  ),
                ),
              ],
              if (__.isBlocked) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  child: SizedBox(
                    width: cs.height(context) * 0.75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TransparentButton(
                            title: 'Unblock',
                            onTap: () async {
                              await __.unblockUser(username: username);
                              __.isBlocked = false;
                              notification.show(
                                title: '${__.user.username} has been unblocked',
                                type: NotificationType.local,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]
            ]
          ],
        );
      },
    );
  }
}
