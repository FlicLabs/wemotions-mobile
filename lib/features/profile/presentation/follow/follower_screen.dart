
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

  //  static Route route({required FollowersScreenArgs args}) {
  //   return getPlatformPageRoute(
  //     builder: (context) => FollowersScreen(username: args.username),
  //     routeName: routeName,
  //   );
  // }

  final String username;

  @override
  State<FollowersScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowersScreen> {
  fetchData() async {
    await Provider.of<ProfileProvider>(context, listen: false).getFollowers(
      username: widget.username,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    final __ = Provider.of<ProfileProvider>(context);
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
        itemCount: __.followers.length,
        itemBuilder: (context, index) {
          return FollowerItem(
            index: index,
            imageUrl: __.followers[index].profilePictureUrl,
            username: __.followers[index].username,
            firstName: __.followers[index].firstName,
            lastName: __.followers[index].lastName,
            isFollowing: __.followers[index].isFollowing,
          );
        },
      ),
    );
  }
}
