import 'package:socialverse/export.dart';

class FollowingItem extends StatelessWidget {
  FollowingItem({
    Key? key,
    this.imageUrl,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isFollowing,
    this.replierType,
    required this.index,
  }) : super(key: key);

  final String? imageUrl;
  final String username;
  final String firstName;
  final String lastName;
  final bool isFollowing;
  final String? replierType;
  final int index;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    // final user = Provider.of<UserProfileProvider>(context);
    return GestureDetector(
      onTap: () {
        // user.page = 1;
        // user.posts.clear();
        // user.user = ProfileModel.empty;
        // Navigator.of(context).pushNamed(
        //   UserProfileScreen.routeName,
        //   arguments: UserProfileScreenArgs(
        //     username: username,
        //   ),
        // );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            GestureDetector(
              child: Row(
                children: [
                  CustomCircularAvatar(
                    imageUrl: imageUrl,
                    height: 40,
                    width: 40,
                  ),
                  width15,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5,
                        Text(
                          replierType??'',
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                  ),
                  width20,
                  Consumer(
                    builder: (_, __, ___) {
                      return prefs_username == username
                          ? shrink
                          : isFollowing
                          ? TransparentButton(
                        title: 'Following',
                        height: 35,
                        width: 120,
                        color: Theme.of(context).canvasColor,
                        borderColor: Constants.primaryColor,
                        textColor: Constants.primaryColor,
                        onTap: () {
                          if (logged_in == true) {
                            // __.toggleFollowing(index);
                            // __.userUnfollow(username: username);
                          } else {
                            auth.showAuthBottomSheet(context);
                          }
                        },
                      )
                          : TransparentButton(
                        title: 'Follow',
                        height: 35,
                        width: 80,
                        color: Constants.primaryColor,
                        isBorder: false,
                        textColor: Constants.lightPrimary,
                        onTap: () {
                          if (logged_in == true) {
                            // __.toggleFollowing(index);
                            // __.userFollow(username: username);
                          } else {
                            auth.showAuthBottomSheet(context);
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
