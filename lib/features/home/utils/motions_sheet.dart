// import 'package:line_icons/line_icons.dart';
import 'package:socialverse/export.dart';

import '../../profile/widgets/profile/profile/following_item.dart';

class MotionSheet extends StatelessWidget {
  final bool? isFromVideoPlayer;
  const MotionSheet({
    Key? key,
    this.isFromVideoPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final notification = Provider.of<NotificationProvider>(context);
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 0, bottom: 40, right: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: SizedBox(
        height: cs.height(context)/2,
        width: cs.width(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: Center(
                      child: Text(
                        'Motions',
                        style: AppTextStyle.ultraMedium,
                      )),
                ),
              ],
            ),
            height10,
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return FollowingItem(
                    index: index,
                    imageUrl: "__.following[index].profilePictureUrl",
                    username: "username",
                    firstName: "firstName",
                    lastName: "lastName",
                    replierType: "Fast Replier",
                    isFollowing: false,
                  );
                },
              ),
            ),
            height24,
          ],
        ),
      ),
    );
  }
}
