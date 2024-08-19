import 'package:socialverse/export.dart';
import 'package:socialverse/features/chat/domain/models/members_model.dart';

class GroupInfoHeader extends StatelessWidget {
  const GroupInfoHeader({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.members,
  });

  final String imageUrl;
  final String username;
  final List<Members> members;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCircularAvatar(
            height: 100,
            width: 100,
            imageUrl: imageUrl,
          ),
          height10,
          Text(
            username,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          height5,
          Text(
            '${'Group ' + '${members.length}' + ' members'}',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    );
  }
}
