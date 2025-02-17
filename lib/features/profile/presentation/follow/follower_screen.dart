

import 'package:socialverse/export.dart';

class FollowersScreenArgs {
  final String username;

  const FollowersScreenArgs({
    required this.username,
  });
}

class FollowersScreen extends StatefulWidget {
  static const String routeName = '/followers';
  const FollowersScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  static Route route({required FollowersScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => FollowersScreen(
        username: args.username,
      ),
    );
  }

  final String username;

  @override
  State<FollowersScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowersScreen> {
  fetchData() async {
    Provider.of<ProfileProvider>(context, listen: false).getFollowers(
      username: widget.username,
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        final followers = profileProvider.followers ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Followers',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: ListView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            itemCount: followers.length,
            itemBuilder: (context, index) {
              final follower = followers[index];
              return FollowerItem(
                index: index,
                imageUrl: follower.profilePictureUrl,
                username: follower.username,
                firstName: follower.firstName,
                lastName: follower.lastName,
                isFollowing: follower.isFollowing,
              );
            },
          ),
        );
      },
    );
  }
}

