import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/presentation/settings/account/change_password_screen.dart';

class ManageAccountScreen extends StatefulWidget {
  static const String routeName = '/manage-account';
  const ManageAccountScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ManageAccountScreen(),
    );
  }

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  void didChangeDependencies() {
    final edit = Provider.of<AccountProvider>(context, listen: false);
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    edit.username.text = profile.user.username;
    edit.firstName.text = profile.user.firstName;
    edit.lastName.text = profile.user.lastName;
    edit.email.text = prefs_email!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Manage Account',
          style: AppTextStyle.normalBold24
              .copyWith(color: Theme.of(context).focusColor),
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            CustomListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AccountInformationScreen.routeName,
                );

              },
              label: 'Account Info',
            ),
            CustomListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ChangePasswordScreen.routeName,
                );
              },
              label: 'Change Password',
            ),
            CustomListTile(
              onTap: () {
                // Navigator.of(context).pushNamed(
                //   AccountInformationScreen.routeName,
                // );
              },
              label: 'Blocked User',
            ),
            CustomListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  DataControlsScreen.routeName,
                );
              },
              label: 'Delete Account',
              textStyle: AppTextStyle.normalBold18.copyWith(color: Colors.red),
              trailing: Icon(
                Icons.keyboard_arrow_right_sharp, 
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
