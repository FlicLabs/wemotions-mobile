import 'package:socialverse/export.dart';

class AuthBottomSheet extends StatelessWidget {
  const AuthBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final reply = Provider.of<ReplyProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Theme.of(context).shadowColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              height10,
              Text(
                "Please sign in to continue",
                style: TextStyle(
                  fontFamily: 'sofia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              height20,
              TransparentButton(
                title: 'Sign In',
                onTap: () {
                  if (home.posts.isNotEmpty && home.isPlaying == true) {
                    home.videoController(home.index)?.pause();
                  }
                  if (reply.posts.isNotEmpty && reply.isPlaying == true) {
                    reply.videoController(reply.index)?.pause();
                  }
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
              ),
              height40,
              // Divider(
              //   thickness: 1,
              //   color: Colors.grey.withOpacity(0.5),
              // ),
              // height10,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text(
              //       'Already have an account?',
              //       style: TextStyle(
              //         fontFamily: 'sofia',
              //         fontSize: 17,
              //         fontWeight: FontWeight.w400,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         // if (home.isPlaying == true) {
              //         //   home.videoController(home.index)?.pause();
              //         // }
              //         Navigator.of(context).pushNamed(LoginScreen.routeName);
              //       },
              //       child: Text(
              //         ' Sign in',
              //         style: TextStyle(
              //           fontFamily: 'sofia',
              //           fontSize: 17,
              //           fontWeight: FontWeight.bold,
              //           color: Theme.of(context).indicatorColor,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
