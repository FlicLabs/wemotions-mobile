import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/profile/profile/following_item.dart';

class FollowingScreenArgs {
  final String username;

  const FollowingScreenArgs({required this.username});
}

class FollowingScreen extends StatefulWidget {
  static const String routeName = '/following';
  const FollowingScreen({Key? key, required this.username}) : super(key: key);

  static Route route({required FollowingScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => FollowingScreen(username: args.username),
    );
  }

  final String username;

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchData());
  }

  void fetchData() {
    Provider.of<ProfileProvider>(context, listen: false)
        .getFollowing(username: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Following',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: profileProvider.following.length,
            itemBuilder: (context, index) {
              final followingUser = profileProvider.following[index];
              return FollowingItem(
                index: index,
                imageUrl: followingUser.profilePictureUrl,
                username: followingUser.username,
                firstName: followingUser.firstName,
                lastName: followingUser.lastName,
                isFollowing: followingUser.isFollowing,
              );
            },
          ),
        );
      },
    );
  }
}

