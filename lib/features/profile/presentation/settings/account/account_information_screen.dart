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
        String updatedUsername = prefs_username!;
        return WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            __.username.text = profile.user.username;
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Account Info',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          height20,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileAlignedText(
                                  title: 'First name',
                                ),
                                height5,
                                ProfileTextFormField(
                                  enabled: true,
                                  hintText: 'First name',
                                  controller: __.firstName,
                                ),
                              ],
                            ),
                          ),
                          width20,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // AuthAlignedText(title: 'Last Name'),
                                ProfileAlignedText(
                                  title: 'Last name',
                                ),
                                height5,
                                ProfileTextFormField(
                                  enabled: true,
                                  hintText: 'Last name',
                                  controller: __.lastName,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      height20,
                      ProfileAlignedText(
                        title: 'Username',
                      ),
                      height5,
                      ProfileTextFormField(
                        controller: __.username,
                        hintText: 'Username',
                        // readOnly: true,
                        enabled: true,
                        onChanged: (val) {
                          updatedUsername = val;
                          if (prefs_username! == updatedUsername) {
                            __.edited = false;
                          } else {
                            __.edited = true;
                          }
                        },
                        // onTap: () {
                        //   __.edited = false;
                        //   Navigator.of(context).pushNamed(
                        //     ChangeUsernameScreen.routeName,
                        //     arguments: ChangeUsernameScreenArgs(
                        //       username: prefs_username!,
                        //     ),
                        //   );
                        // },
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
                    ],
                  ),
                  AuthButtonWithColor(
                      title: 'Confirm',
                      onTap: () async {
                        final response = await __.updateUsername(context);
                        if (response == 200 || response == 201) {
                          await profile.fetchProfile(
                            username: prefs_username!,
                            forceRefresh: true,
                          );
                        }
                      },
                      isGradient: __.username.text.isNotEmpty && __.edited)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
