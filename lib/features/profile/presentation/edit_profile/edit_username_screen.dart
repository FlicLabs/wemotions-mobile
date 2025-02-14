import 'package:socialverse/export.dart';

class EditUsernameScreenArgs {
  final String username;

  const EditUsernameScreenArgs({
    required this.username,
  });
}

class EditUsernameScreen extends StatelessWidget {
  static const String routeName = '/edit-username';
  
  const EditUsernameScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  static Route route({required EditUsernameScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => EditUsernameScreen(
        username: args.username,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (_, provider, ___) {
        final profile = Provider.of<ProfileProvider>(context, listen: false);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Username',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
            actions: [
              if (!provider.loading)
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  child: SaveButton(
                    onTap: () async {
                      if (provider.username.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Username cannot be empty')),
                        );
                        return;
                      }
                      final response = await provider.updateUsername(context);
                      if (response == 200 || response == 201) {
                        await profile.fetchProfile(
                          username: prefs_username ?? '',
                          forceRefresh: true,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileAlignedText(title: 'Username'),
                  height5,
                  ProfileTextFormField(
                    controller: provider.username,
                    hintText: 'Username', // Fixed hint text
                    autofocus: true,
                    enabled: true,
                    onChanged: (val) {
                      provider.edited = username.trim() != val.trim();
                    },
                  ),
                  height20,
                  Text(
                    'Your username cannot be changed at the moment. This feature will be available soon.',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 15),
                  ),
                  height40,
                  if (provider.loading)
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CustomProgressIndicator(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

