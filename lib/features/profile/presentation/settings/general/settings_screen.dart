import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/settings/icon_list_tile.dart';

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
    return Consumer<SettingsProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings & Privacy',
              style: Theme.of(context).textTheme.bodyLarge,
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
                    'ACCOUNT',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  IconListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ManageAccountScreen.routeName,
                      );
                    },
                    svg: AppAsset.icuser,
                    label: 'Manage Account',
                  ),
                  Divider(color: Colors.grey),
                  height10,
                  Text(
                    'GENERAL',
                    style: Theme.of(context).textTheme.bodyLarge,
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
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          'http://indoctrinate.holyvible.com/',
                        ),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    svg: AppAsset.icglobe,
                    label: 'Explore the Holy Vible',
                    trailing: shrink,
                    height: 24,
                  ),
                  IconListTile(
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          'http://app.holyvible.com/',
                        ),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    svg: AppAsset.icglobe,
                    label: 'Search for the best vibes',
                    trailing: shrink,
                    height: 24,
                  ),
                  IconListTile(
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          'http://holyvibles.com/',
                        ),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    svg: AppAsset.icglobe,
                    label: 'One Vibe Tribe',
                    trailing: shrink,
                    height: 24,
                  ),
                  IconListTile(
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          'https://holyvible.com/privacy-policy',
                        ),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    svg: AppAsset.icprivacy,
                    label: 'Privacy Policy',
                    trailing: shrink,
                  ),
                  IconListTile(
                    onTap: () async {
                      await launchUrl(
                        Uri.parse(
                          'https://holyvible.com/terms-and-conditions',
                        ),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                    svg: AppAsset.icdigital,
                    label: 'Terms & Conditions',
                    trailing: shrink,
                  ),
                  IconListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ThemeSwitchScreen.routeName,
                      );
                    },
                    svg: AppAsset.ictheme,
                    label: 'Theme',
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
