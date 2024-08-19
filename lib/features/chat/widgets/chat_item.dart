import 'package:socialverse/export.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });

  final bool isCurrentUser;
  final Messages message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      isSender: isCurrentUser,
      text: message.message,
      sender: message.sender.username ?? '',
      color: isCurrentUser
          ? Theme.of(context).hintColor
          : Theme.of(context).hoverColor,
      tail: true,
      sent: isCurrentUser,
      onTap: () {
        Navigator.of(context).pushNamed(
          UserProfileScreen.routeName,
          arguments: UserProfileScreenArgs(
            username: message.sender.username,
          ),
        );
      },
    );
  }
}
