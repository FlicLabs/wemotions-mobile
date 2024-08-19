import 'package:socialverse/export.dart';

class InviteItem extends StatelessWidget {
  InviteItem({
    Key? key,
    this.imageUrl,
    required this.firstName,
    this.lastName,
    required this.telephone,
    required this.index,
  }) : super(key: key);

  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? telephone;
  final int index;

  Widget build(BuildContext context) {
    final invite = Provider.of<InviteProvider>(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          GestureDetector(
            child: Row(
              children: [
                CustomCircularAvatar(
                  imageUrl: imageUrl,
                  height: 40,
                  width: 40,
                ),
                width15,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstName ?? '',
                        style: Theme.of(context).textTheme.headlineMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      height5,
                      Text(
                        telephone ?? '',
                        style: Theme.of(context).textTheme.displaySmall,
                      )
                    ],
                  ),
                ),
                width20,
                Consumer<InviteProvider>(
                  builder: (_, __, ___) {
                    return ImageButton(
                      title: 'Invite',
                      height: 35,
                      width: 120,
                      onTap: () {
                        invite.inviteContact(telephone);
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
