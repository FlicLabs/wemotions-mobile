
import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/profile/invite/add_item.dart';
import 'package:socialverse/features/profile/widgets/profile/invite/invite_list_tile_item.dart';

class AddFriendsScreen extends StatefulWidget {
  static const String routeName = '/add-friends';
  const AddFriendsScreen({super.key});

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const AddFriendsScreen(),
    );
  }

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final inviteProvider = Provider.of<InviteProvider>(context, listen: false);
      inviteProvider.fetchActiveUsers();
      inviteProvider.getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final invite = Provider.of<InviteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Friends',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              InviteTileItem(
                icon: UniconsLine.share,
                onTap: () => Navigator.of(context).pushNamed(InviteScreen.routeName),
                label: 'Invite Friends',
              ),
              const SizedBox(height: 20),
              Text(
                'Suggested People',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: Platform.isIOS ? 40 : 20),
                itemCount: invite.active_users.length,
                itemBuilder: (context, index) {
                  final user = invite.active_users[index];
                  return AddItem(
                    index: index,
                    imageUrl: user.profilePictureUrl,
                    username: user.username,
                    firstName: user.firstName,
                    lastName: user.lastName,
                    isFollowing: user.isFollowing,
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

