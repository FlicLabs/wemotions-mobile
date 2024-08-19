import 'package:socialverse/export.dart';
import 'package:socialverse/features/chat/domain/models/members_model.dart';
import 'package:socialverse/features/chat/widgets/member_list_item.dart';

import '../widgets/group_info_header.dart';

class GroupChatDetailScreenArgs {
  final String username;
  final String imageUrl;
  final List<Members> members;

  const GroupChatDetailScreenArgs({
    required this.username,
    required this.imageUrl,
    required this.members,
  });
}

class GroupChatDetailScreen extends StatelessWidget {
  static const String routeName = '/gc-detail';
  const GroupChatDetailScreen({
    Key? key,
    required this.username,
    required this.imageUrl,
    required this.members,
  }) : super(key: key);

  static Route route({required GroupChatDetailScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => GroupChatDetailScreen(
        imageUrl: args.imageUrl,
        username: args.username,
        members: args.members,
      ),
    );
  }

  final String username;
  final String imageUrl;
  final List<Members> members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Info',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            height20,
            GroupInfoHeader(
              imageUrl: imageUrl,
              username: username,
              members: members,
            ),
            height20,
            ListView.builder(
              shrinkWrap: true,
              itemCount: members.length,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
              itemBuilder: (context, index) {
                return MemberListItem(member: members[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
