import 'package:socialverse/export.dart';

class FollowerItem extends StatefulWidget {
  FollowerItem({
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

  @override
  State<FollowerItem> createState() => _FollowerItemState();
}

class _FollowerItemState extends State<FollowerItem> {

  late final AuthProvider auth;
  late final UserProfileProvider user;
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    auth = Provider.of<AuthProvider>(context,listen: false);
    user = Provider.of<UserProfileProvider>(context,listen: false);
    isFollowing= widget.isFollowing;
  }

  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        user.page = 1;
        user.posts.clear();
        user.user = ProfileModel.empty;
        Navigator.of(context).pushNamed(
          UserProfileScreen.routeName,
          arguments: UserProfileScreenArgs(
            username: widget.username,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            GestureDetector(
              child: Row(
                children: [
                  CustomCircularAvatar(
                    imageUrl: widget.imageUrl,
                    height: 40,
                    width: 40,
                  ),
                  width15,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.firstName + ' ' + widget.lastName,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height5,
                        Text(
                          widget.username,
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      ],
                    ),
                  ),
                  width20,
                  Consumer<ProfileProvider>(
                    builder: (_, __, ___) {
                      return prefs_username == widget.username
                          ? shrink
                          : isFollowing
                          ? TransparentButton(
                        title: 'Following',
                        height: 35,
                        width: 120,
                        color: Theme.of(context).canvasColor,
                        borderColor: Constants.primaryColor,
                        textColor: Constants.primaryColor,
                        onTap: () async{
                          if (logged_in == true) {
                            // __.toggleFollowing(index);
                            // __.userUnfollow(username: username);
                            __.followUser(username: widget.username, isFollowing: true);

                            setState(() {
                              isFollowing= false;
                            });

                            await __.fetchProfile(username: prefs_username??'',forceRefresh: true);

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
                        onTap: () async {
                          if (logged_in == true) {
                            // __.toggleFollowing(index);
                            // __.userFollow(username: username);
                            __.followUser(username: widget.username, isFollowing: false);
                            setState(() {
                              isFollowing= true;
                            });

                            await __.fetchProfile(username: prefs_username??'',forceRefresh: true);

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
