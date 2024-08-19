import 'package:socialverse/export.dart';
import 'package:socialverse/features/chat/domain/models/members_model.dart';

class MemberListItem extends StatelessWidget {
  final Members member;

  const MemberListItem({
    Key? key,
    required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProfileProvider>(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      onTap: () {
        user.page = 1;
        user.posts.clear();
        user.user = ProfileModel.empty;
        Navigator.of(context).pushNamed(
          UserProfileScreen.routeName,
          arguments: UserProfileScreenArgs(
            username: member.username,
          ),
        );
      },
      leading: CustomCircularAvatar(
        height: 30,
        width: 30,
        imageUrl: member.profileUrl,
      ),
      title: Text(
        member.username == prefs_username
            ? 'You'
            : '${member.firstName} ${member.lastName}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: member.username == prefs_username
          ? null
          : Text(
              member.username,
              style: Theme.of(context).textTheme.displaySmall,
            ),
      trailing: Icon(
        Icons.keyboard_arrow_right_sharp,
        color: Theme.of(context).focusColor,
      ),
    );
  }
}
