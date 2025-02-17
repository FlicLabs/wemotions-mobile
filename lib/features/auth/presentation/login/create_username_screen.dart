import 'package:socialverse/export.dart';

class CreateUsernameScreenArgs {
  final String username;

  const CreateUsernameScreenArgs({required this.username});
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
      builder: (context) => CreateUsernameScreen(username: args.username),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
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
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: AuthSaveButton(
                  onTap: () async {
                    if (authProvider.usernameFK.currentState!.validate()) {
                      final response = await authProvider.updateUsername(context);
                      if (response == 200 || response == 201) {
                        await profile.fetchProfile(
                          username: prefs_username!,
                          forceRefresh: true,
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileAlignedText(title: 'Username'),
                height5,
                Form(
                  key: authProvider.usernameFK,
                  child: AuthTextFormField(
                    controller: authProvider.username,
                    hintText: 'Username',
                    autofocus: true,
                    enabled: true,
                    onChanged: (val) {
                      authProvider.edited = username != val;
                    },
                  ),
                ),
                height20,
                if (authProvider.loading)
                  const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
