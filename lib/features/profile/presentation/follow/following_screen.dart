
import 'package:socialverse/export.dart';

class FollowingScreenArgs {
  final String username;

  const FollowingScreenArgs({
    required this.username,
  });
}

class FollowingScreen extends StatefulWidget {
  static const String routeName = '/following';
  const FollowingScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  static Route route({required FollowingScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => FollowingScreen(
        username: args.username,
      ),
    );
  }

  final String username;

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  fetchData() async {
    await Provider.of<ProfileProvider>(context, listen: false).getFollowing(
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
    return Consumer<ProfileProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Following',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemCount: __.following.length,
            itemBuilder: (context, index) {
              return FollowingItem(
                index: index,
                imageUrl: __.following[index].profilePictureUrl,
                username: __.following[index].username,
                firstName: __.following[index].firstName,
                lastName: __.following[index].lastName,
                isFollowing: __.following[index].isFollowing,
              );
            },
          ),
        );
      },
    );
  }
}
