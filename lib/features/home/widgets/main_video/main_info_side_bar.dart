import 'package:socialverse/export.dart';

class MainInfoSideBar extends StatelessWidget {
  const MainInfoSideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (_, __, ___) {
        final postTitle = __.posts[__.index].title;
        return Positioned(
          left: 15,
          bottom: __.downloading == true || __.downloadingCompleted
              ? cs().height(context) * 0.04
              : cs().height(context) * 0.02,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // SizedBox(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           if (__.videoController(__.index)!.value.isPlaying) {
              //             __.videoController(__.index)!.pause();
              //           }
              //           if (logged_in == true) {
              //             Navigator.of(context)
              //                 .pushNamed(
              //                   ProfileScreen.routeName,
              //                   arguments: ProfileScreenArgs(
              //                     username: __.posts[__.index].username,
              //                     mainUser: false,
              //                     isFollowing: (isFollowing) {
              //                       __.isFollowing = isFollowing;
              //                     },
              //                   ),
              //                 )
              //                 .then(
              //                   (value) => __.videoController(__.index)!.play(),
              //                 );
              //             log(__.posts[__.index].username);
              //           } else {
              //             auth.showAuthBottomSheet(context);
              //           }
              //         },
              //         child: Text(
              //           "@" + __.posts[__.index].username,
              //           overflow: TextOverflow.ellipsis,
              //           style: TextStyle(
              //             fontFamily: 'sofia',
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //       width10,
              //       if (__.posts[__.index].username != prefs_username)
              //         GestureDetector(
              //           onTap: () {
              //             if (logged_in == true) {
              //               user.followUser(
              //                 context,
              //                 username: __.posts[__.index].username,
              //                 isFollowing: __.isFollowing,
              //               );
              //               if (__.isFollowing == true) {
              //                 __.isFollowing = false;
              //               } else {
              //                 __.isFollowing = true;
              //               }
              //               log(__.isFollowing.toString());
              //             } else {
              //               auth.showAuthBottomSheet(context);
              //             }
              //           },
              //           child: Container(
              //             height: 32,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(5),
              //               border: Border.all(
              //                 color: Colors.white.withOpacity(0.2),
              //                 width: 1,
              //               ),
              //             ),
              //             padding: const EdgeInsets.all(4),
              //             child: Center(
              //               child: Text(
              //                 __.isFollowing == true
              //                     ? 'unsubscribe'
              //                     : 'subscribe',
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontFamily: 'sofia',
              //                   fontSize: 14,
              //                   // fontWeight: FontWeight.bold,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
              // height5,
              if (__.posts[__.index].title.isNotEmpty) ...[
                SizedBox(
                  width: cs().width(context) - 100,
                  child: GestureDetector(
                    onTap: () => __.toggleTextExpanded(),
                    child: Linkify(
                      onOpen: (link) async {
                        if (await canLaunchUrl(Uri.parse(link.url))) {
                          await launchUrl(Uri.parse(link.url));
                        } else {
                          throw 'Could not launch $link';
                        }
                      },
                      text: postTitle,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.normalRegular,
                      textAlign: TextAlign.start,
                      maxLines: __.isTextExpanded
                          ? (5 + (6 * __.expansionProgress)).round()
                          : 1,
                      linkStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
