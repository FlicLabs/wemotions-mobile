import 'package:socialverse/export.dart';


class CreateUsernameScreenArgs {
  final String username;

  const CreateUsernameScreenArgs({
    required this.username,
  });
}

class CreateUsernameScreen extends StatelessWidget {
  static const String routeName = '/create-new-username';
  const CreateUsernameScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  static Route route({required CreateUsernameScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CreateUsernameScreen(
        username: args.username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        String updatedUsername = username;
        return Scaffold(
          appBar: AppBar(
            leading: shrink,
            title: Text(
              'Username',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 20,
                ),
                child: AuthSaveButton(
                  onTap: () async {
                    // if (__.usernameFK.currentState!.validate()) {
                    //   final response = await __.updateUsername(context);
                    //   if (response == 200 || response == 201) {
                    //     await profile.fetchProfile(
                    //       username: prefs_username!,
                    //       forceRefresh: true,
                    //     );
                    //   }
                    // }
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
                  Form(
                    key: __.usernameFK,
                    child: AuthTextFormField(
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
                  ),
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
