import 'package:socialverse/export.dart';

class AddItem extends StatelessWidget {
  AddItem({
    Key? key,
    this.imageUrl,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isFollowing,
    required this.index,
  }) : super(key: key);

  final String? imageUrl;
  final String username;
  final String firstName;
  final String lastName;
  final bool isFollowing;
  final int index;

  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<UserProfileProvider>(context);
    return GestureDetector(
      onTap: () {
        user.page = 1;
        user.posts.clear();
        user.user = ProfileModel.empty;
        Navigator.of(context).pushNamed(
          UserProfileScreen.routeName,
          arguments: UserProfileScreenArgs(
            username: username,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
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
                          firstName + ' ' + lastName,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5,
                        Text(
                          'suggested user',
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      ],
                    ),
                  ),
                  width20,
                  Consumer<InviteProvider>(
                    builder: (_, __, ___) {
                      return prefs_username == username
                          ? shrink
                          : isFollowing
                              ? TransparentButton(
                                  title: 'Unsubscribe',
                                  height: 35,
                                  width: 120,
                                  onTap: () {
                                    __.toggleFollowing(index);
                                    __.userUnfollow(username: username);
                                    profile.fetchProfile(
                                      username: prefs_username!,
                                    );
                                  },
                                )
                              : TransparentButton(
                                  title: 'Subscribe',
                                  height: 35,
                                  width: 120,
                                  onTap: () {
                                    __.toggleFollowing(index);
                                    __.userFollow(username: username);
                                    profile.fetchProfile(
                                      username: prefs_username!,
                                    );
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
