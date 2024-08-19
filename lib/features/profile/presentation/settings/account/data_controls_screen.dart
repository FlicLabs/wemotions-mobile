
import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/settings/icon_list_tile.dart';

class DataControlsScreen extends StatelessWidget {
  static const String routeName = '/data-controls';
  const DataControlsScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => DataControlsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<BottomNavBarProvider>(context);
    final account = Provider.of<AccountProvider>(context);
    return Consumer<SettingsProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            leading: account.loading ? shrink : null,
            title: Text(
              'Data Controls',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                IconListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Delete Account',
                        action: 'Delete',
                        content:
                            'By proceeding to delete your account your are agreeing to remove any data associated with your account, that is posts, liked posts, followers/following and all other account information, doing so will remove your data and close the app.\n\nAre you sure you want to proceed?',
                        tap: () async {
                          // __.deleteAccount(context);
                          HapticFeedback.heavyImpact();
                          nav.currentPage = 0;
                          nav.jumpToPage();
                          await account.logout(context);
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                      ),
                    );
                  },
                  svg: AppAsset.bin,
                  label: 'Delete Account',
                  color: Colors.red,
                  trailing: shrink,
                ),
                height20,
                if (account.loading) ...[
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomProgressIndicator(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
