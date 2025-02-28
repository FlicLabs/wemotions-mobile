import 'package:socialverse/export.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<BottomNavBarProvider>(context);
    final account = Provider.of<AccountProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    return Consumer<SettingsProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text(
              'Settings',
              style: AppTextStyle.normalBold24
                  .copyWith(color: Theme.of(context).focusColor),
              textAlign: TextAlign.start,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height20,
                  Text(
                    'Account',
                    style: AppTextStyle.normalBold24
                        .copyWith(color: Theme.of(context).focusColor, fontSize: 20),
                  ),
                  IconListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ManageAccountScreen.routeName,
                      );
                    },
                    svg: AppAsset.icuser_active,
                    color: Theme.of(context).focusColor.withOpacity(0.8),
                    label: 'Manage Account',
                  ),
                  // Divider(color: Colors.grey),
                  height20,
                  Text(
                    'General',
                    style: AppTextStyle.normalBold24.copyWith(color: Theme.of(context).focusColor,fontSize: 20),
                  ),
                  // CustomListTile(
                  //   onTap: () async {
                  //     await launchUrl(
                  //         Uri.parse(
                  //           'https://discord.gg/RDmtVCkN',
                  //         ),
                  //         mode: LaunchMode.inAppWebView);
                  //   },
                  //   svg: AppAsset.icuser,
                  //   label: 'Join our discord server',
                  //   trailing: shrink,
                  // ),
                  // IconListTile(
                  //   onTap: () async {
                  //     await launchUrl(
                  //       Uri.parse(
                  //         'https://www.socialverseapp.com/whitepaper',
                  //       ),
                  //       mode: LaunchMode.inAppWebView,
                  //     );
                  //   },
                  //   svg: AppAsset.icglobe,
                  //   label: 'Read our Mission',
                  //   trailing: shrink,
                  //   height: 24,
                  // ),
                  IconListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ThemeSwitchScreen.routeName,
                      );
                    },
                    svg: AppAsset.ictheme,
                    color: Theme.of(context).focusColor.withOpacity(0.8),
                    label: 'Theme',
                  ),
                  IconListTile(
                    onTap: () async {
                      // await launchUrl(
                      //   Uri.parse(
                      //     '',
                      //   ),
                      //   mode: LaunchMode.inAppWebView,
                      // );
                    },
                    svg: AppAsset.icprivacy,
                    label: 'Privacy Policy',
                    color: Theme.of(context).focusColor.withOpacity(0.8),
                    trailing: shrink,
                  ),
                  IconListTile(
                    onTap: () async {
                      // await launchUrl(
                      //   Uri.parse(
                      //     '',
                      //   ),
                      //   mode: LaunchMode.inAppWebView,
                      // );
                    },
                    svg: AppAsset.icterms,
                    label: 'Terms & Conditions',
                    color: Theme.of(context).focusColor.withOpacity(0.8),
                    trailing: shrink,
                  ),
                  IconListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          title: prefs_username!,
                          action: 'Sign Out',
                          content: 'Are you sure you want to log out of WeMotions?',
                          tap: () {
                            HapticFeedback.heavyImpact();
                            nav.currentPage = 0;
                            profile.user = ProfileModel.empty;
                            profile.posts.clear();
                            account.logout(context: context);
                          },
                        ),
                      );
                    },
                    svg: AppAsset.iclogout,
                    label: 'Sign out',
                    textStyle:  AppTextStyle.normalBold18.copyWith(color: Colors.red),
                    trailing: shrink,
                    color: Colors.red,
                  ),
                  
                  // Divider(color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
