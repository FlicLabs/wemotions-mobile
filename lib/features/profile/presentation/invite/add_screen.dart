
import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/profile/invite/add_item.dart';
import 'package:socialverse/features/profile/widgets/profile/invite/invite_list_tile_item.dart';


class AddFriendsScreen extends StatefulWidget {
  static const String routeName = '/add-friends';
  const AddFriendsScreen({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => AddFriendsScreen(),
    );
  }

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  fetchData() async {
    Provider.of<InviteProvider>(context, listen: false).fetchActiveUsers();
  }

  fetchContacts() async {
    Provider.of<InviteProvider>(context, listen: false).getContacts();
  }

  fetchLink() {
    Provider.of<InviteProvider>(context, listen: false).getInviteLink();
  }

  initState() {
    fetchData();
    fetchContacts();
    fetchLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invite = Provider.of<InviteProvider>(context);
    //invite.followers.removeWhere((follower) => follower.isFollowing == true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Friends',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height20,
              InviteTileItem(
                icon: UniconsLine.share,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    InviteScreen.routeName,
                  );
                },
                label: 'Invite Friends',
              ),
              height20,
              Text(
                'Suggested People',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 16),
              ),
              height20,
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: Platform.isIOS ? 40 : 20,
                ),
                itemCount: invite.active_users.length,
                itemBuilder: (context, index) {
                  return AddItem(
                    index: index,
                    imageUrl: invite.active_users[index].profilePictureUrl,
                    username: invite.active_users[index].username,
                    firstName: invite.active_users[index].firstName,
                    lastName: invite.active_users[index].lastName,
                    isFollowing: invite.active_users[index].isFollowing,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
