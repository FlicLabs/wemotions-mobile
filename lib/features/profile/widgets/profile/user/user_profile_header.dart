import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/utils/profile_share_sheet.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    // final wallet = Provider.of<WalletProvider>(context);
    return Consumer<UserProfileProvider>(
      builder: (_, __, ___) {
        return Row(
          children: [
            if (username != prefs_username) ...[
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    // if (__.user.hasWallet == true) ...[
                    //   GestureDetector(
                    //     onTap: () {
                    //       wallet.recipient.text = __.user.walletAddress;
                    //       Navigator.pushNamed(context, SendScreen.routeName);
                    //     },
                    //     child: SvgPicture.asset(
                    //       AppAsset.icwallet,
                    //       height: 20,
                    //       width: 20,
                    //       color: Theme.of(context).indicatorColor,
                    //     ),
                    //   ),
                    //   width10,
                    // ],
                    GestureDetector(
                      onTap: () async {
                        await HapticFeedback.mediumImpact();
                        // final link = await __.dynamicLink.createProfileLink(
                        //   imageUrl: __.user.profilePictureUrl,
                        //   username: __.user.username,
                        //   first_name: __.user.firstName,
                        //   followers: '${__.user.followerCount}',
                        //   following: '${__.user.followingCount}',
                        //   posts: '${__.user.postCount}',
                        //   isProfile: true,
                        // );
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          builder: (context) {
                            return ProfileShareSheet(
                              // dynamicLink: link,
                            );
                          },
                        );
                      },
                      child: Icon(
                        CupertinoIcons.ellipsis_vertical,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ],
                ),
              )
            ]
          ],
        );
      },
    );
  }
}
