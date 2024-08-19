import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/settings/icon_list_tile.dart';

class AccountInformationScreen extends StatelessWidget {
  static const String routeName = '/account-info';
  const AccountInformationScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => AccountInformationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<BottomNavBarProvider>(context);
    final account = Provider.of<AccountProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    return Consumer<AccountProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Account Info',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                height20,
                ProfileAlignedText(
                  title: 'Username',
                ),
                height5,
                ProfileTextFormField(
                  controller: __.username,
                  hintText: 'Username',
                  readOnly: true,
                  enabled: true,
                  onTap: () {
                    __.edited = false;
                    Navigator.of(context).pushNamed(
                      ChangeUsernameScreen.routeName,
                      arguments: ChangeUsernameScreenArgs(
                        username: prefs_username!,
                      ),
                    );
                  },
                ),
                height20,
                ProfileAlignedText(
                  title: 'Email',
                ),
                height5,
                ProfileTextFormField(
                  controller: __.email,
                  hintText: 'Username',
                  readOnly: true,
                  enabled: false,
                  onTap: () {
                    // Navigator.of(context).pushNamed(
                    //   EditUsernameScreen.routeName,
                    //   arguments: EditUsernameScreenArgs(
                    //     username: prefs_username!,
                    //   ),
                    // );
                  },
                ),
                height10,
                Text(
                  'Your email ${__.email.text} cannot be changed at the moment',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 15),
                ),
                height40,
                IconListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: prefs_username!,
                        action: 'Log Out',
                        content: 'Are you sure you want to log out of Vible?',
                        tap: () {
                          HapticFeedback.heavyImpact();
                          nav.currentPage = 0;
                          profile.user = ProfileModel.empty;
                          profile.posts.clear();
                          account.logout(context);
                        },
                      ),
                    );
                  },
                  svg: AppAsset.iclogout,
                  label: 'Log out',
                  trailing: shrink,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
