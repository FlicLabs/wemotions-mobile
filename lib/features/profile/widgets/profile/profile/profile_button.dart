import 'package:socialverse/export.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, __, ___) {
        return Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: SizedBox(
            width: cs().height(context) * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ImageButton(
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        EditProfileScreen.routeName,
                        arguments: EditProfileScreenArgs(
                          username: prefs_username!,
                          name: __.user.name,
                          bio: __.user.bio,
                          firstname: __.user.firstName,
                          surname: __.user.lastName,
                          imageUrl: __.user.profilePictureUrl,
                          website: __.user.website,
                          tiktok: __.user.tiktokUrl,
                          instagram: __.user.instagramUrl,
                          youtube: __.user.youtubeUrl,
                        ),
                      );
                    },
                  ),
                ),
                // CustomPopUpButton(mainUser: mainUser),
              ],
            ),
          ),
        );
      },
    );
  }
}
