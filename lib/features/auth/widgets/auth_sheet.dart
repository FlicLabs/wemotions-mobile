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
          padding: const EdgeInsets.only(left: 24,right: 24,top: 16,bottom: 16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Theme.of(context).shadowColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey.shade600,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              height40,
              Text(
                "Join Us to Continue",
                style: TextStyle(
                  fontFamily: 'sofia',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              height24,
              Text(
                "To continue, please log in or sign up for an",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'sofia',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              Text(
                "account. Don't miss out on the full experience!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'sofia',
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              height40,
              AuthButtonWithColor(
                isGradient: true,
                title: 'Join Us',
                onTap: () {
                  if (home.posts.isNotEmpty && home.isPlaying == true) {
                    home.videoController(home.index)?.pause();
                  }
                  if (reply.posts.isNotEmpty && reply.isPlaying == true) {
                    reply.videoController(reply.index)?.pause();
                  }
                  Navigator.of(context).pushNamed(OnboardingScreen.routeName);
                },
              ),
              height40,
            ],
          ),
        ),
      ],
    );
  }
}
