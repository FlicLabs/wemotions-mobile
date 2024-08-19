import 'package:socialverse/export.dart';

class EditLinksScreenArgs {
  final String website;
  final String instagram;
  final String tiktok;
  final String youtube;

  const EditLinksScreenArgs({
    required this.website,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
  });
}

class EditLinksScreen extends StatelessWidget {
  static const String routeName = '/edit-links';
  const EditLinksScreen({
    Key? key,
    required this.website,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
  }) : super(key: key);

  final String website;
  final String instagram;
  final String tiktok;
  final String youtube;

  static Route route({required EditLinksScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => EditLinksScreen(
        website: args.website,
        instagram: args.instagram,
        tiktok: args.tiktok,
        youtube: args.youtube,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (_, __, ___) {
        final profile = Provider.of<ProfileProvider>(context);
        String updatedWebsite = website;
        String updatedTiktok = tiktok;
        String updatedYoutube = youtube;
        String updatedInstagram = instagram;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: __.loading ? Container() : null,
              title: Text(
                'Links',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.start,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    top: 20,
                  ),
                  child: SaveButton(
                    onTap: () async {
                      __.edited = false;
                      final response = await __.updateLinks(context);
                      if (response == 200 || response == 201) {
                        await profile.fetchProfile(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAlignedText(
                      title: 'Website',
                    ),
                    height5,
                    ProfileTextFormField(
                      controller: __.website,
                      hintText: 'Website',
                      enabled: true,
                      autofocus: true,
                      onChanged: (val) {
                        updatedWebsite = val;
                        if (website == updatedWebsite) {
                          __.edited = false;
                        } else {
                          __.edited = true;
                        }
                      },
                    ),
                    height20,
                    ProfileAlignedText(
                      title: 'Instagram',
                    ),
                    height5,
                    ProfileTextFormField(
                      controller: __.instagram,
                      hintText: 'Instagram',
                      enabled: true,
                      autofocus: true,
                      onChanged: (val) {
                        updatedInstagram = val;
                        if (instagram == updatedInstagram) {
                          __.edited = false;
                        } else {
                          __.edited = true;
                        }
                      },
                    ),
                    height20,
                    ProfileAlignedText(
                      title: 'Tiktok',
                    ),
                    height5,
                    ProfileTextFormField(
                      controller: __.tiktok,
                      hintText: 'Tiktok',
                      enabled: true,
                      autofocus: true,
                      onChanged: (val) {
                        updatedTiktok = val;
                        if (tiktok == updatedTiktok) {
                          __.edited = false;
                        } else {
                          __.edited = true;
                        }
                      },
                    ),
                    height20,
                    ProfileAlignedText(
                      title: 'Youtube',
                    ),
                    height5,
                    ProfileTextFormField(
                      controller: __.youtube,
                      hintText: 'Youtube',
                      enabled: true,
                      autofocus: true,
                      onChanged: (val) {
                        updatedYoutube = val;
                        if (youtube == updatedYoutube) {
                          __.edited = false;
                        } else {
                          __.edited = true;
                        }
                      },
                    ),
                    height40,
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
          ),
        );
      },
    );
  }
}
