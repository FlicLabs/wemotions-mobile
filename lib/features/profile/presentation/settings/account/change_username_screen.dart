import 'package:socialverse/export.dart';
import 'package:socialverse/features/profile/widgets/account/account_save_button.dart';

class ChangeUsernameScreenArgs {
  final String username;

  const ChangeUsernameScreenArgs({
    required this.username,
  });
}

class ChangeUsernameScreen extends StatelessWidget {
  static const String routeName = '/change-username';
  const ChangeUsernameScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  static Route route({required ChangeUsernameScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChangeUsernameScreen(
        username: args.username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (_, __, ___) {
        final user = Provider.of<ProfileProvider>(context);
        String updatedUsername = username;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Change username',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 20,
                ),
                child: AccountSaveButton(
                  onTap: () async {
                    final response = await __.updateUsername(context);
                    if (response == 200 || response == 201) {
                      await user.fetchProfile(
                        username: prefs_username!,
                        forceRefresh: true,
                      );
                    }
                  },
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileAlignedText(
                    title: 'Username',
                  ),
                  height5,
                  ProfileTextFormField(
                    controller: __.username,
                    hintText: 'Username',
                    autofocus: true,
                    enabled: true,
                    onChanged: (val) {
                      updatedUsername = val;
                      if (username == updatedUsername) {
                        __.edited = false;
                      } else {
                        __.edited = true;
                      }
                    },
                  ),
                  // height20,
                  // Text(
                  //   'Your username ${username} cannot be changed at the moment, this feature will be available soon.',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .displaySmall!
                  //       .copyWith(fontSize: 15),
                  // ),
                  height20,
                  height20,
                  if (__.loading) ...[
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
          ),
        );
      },
    );
  }
}
