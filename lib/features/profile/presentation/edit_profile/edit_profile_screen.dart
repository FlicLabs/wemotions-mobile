import 'package:socialverse/export.dart';

class EditProfileScreenArgs {
  final String username;
  final String name;
  final String bio;
  final String firstname;
  final String surname;
  final String imageUrl;
  final String website;
  final String instagram;
  final String tiktok;
  final String youtube;

  const EditProfileScreenArgs({
    required this.username,
    required this.name,
    required this.bio,
    required this.firstname,
    required this.surname,
    required this.imageUrl,
    required this.website,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
  });
}

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';
  const EditProfileScreen({
    Key? key,
    required this.username,
    required this.name,
    required this.bio,
    required this.firstname,
    required this.surname,
    required this.imageUrl,
    required this.website,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
  }) : super(key: key);

  final String username;
  final String name;
  final String bio;
  final String firstname;
  final String surname;
  final String imageUrl;
  final String website;
  final String instagram;
  final String tiktok;
  final String youtube;

  static Route route({required EditProfileScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => EditProfileScreen(
        username: args.username,
        name: args.name,
        bio: args.bio,
        firstname: args.firstname,
        surname: args.surname,
        imageUrl: args.imageUrl,
        website: args.website,
        instagram: args.instagram,
        tiktok: args.tiktok,
        youtube: args.youtube,
      ),
    );
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  void didChangeDependencies() {
    final edit = Provider.of<EditProfileProvider>(context, listen: false);
    final user = Provider.of<ProfileProvider>(context, listen: false);
    edit.username.text = user.user.username;
    edit.name.text = user.user.name;
    edit.bio.text = user.user.bio;
    edit.firstname.text = user.user.firstName;
    edit.surname.text = user.user.lastName;
    edit.website.text = user.user.website;
    edit.tiktok.text = user.user.tiktokUrl;
    edit.instagram.text = user.user.instagramUrl;
    edit.youtube.text = user.user.youtubeUrl;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileProvider>(context);
    return Consumer<EditProfileProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: __.loading ? Container() : null,
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await __.selectProfilePhoto(context);
                    },
                    child: Column(
                      children: [
                        if (widget.imageUrl.isEmpty) ...[
                          SvgPicture.asset(
                            AppAsset.icuser,
                            height: 100,
                            width: 100,
                          ),
                          height10,
                          Text(
                            'Tap to add Subverse photo',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          )
                        ],
                        if (widget.imageUrl.isNotEmpty &&
                            __.selectedImage?.path == null) ...[
                          CustomCircularAvatar(
                            imageUrl: widget.imageUrl,
                            height: 100,
                            width: 100,
                          ),
                          height10,
                          Text(
                            'Change profile photo',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).indicatorColor,
                              fontFamily: 'sofia',
                            ),
                          ),
                        ],
                        if (__.selectedImage?.path != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              File(__.selectedImage!.path),
                              height: 100,
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          ),
                          height10,
                          Text(
                            'Change profile photo',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).indicatorColor,
                              fontFamily: 'sofia',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // height20,
                  // CustomCircularAvatar(
                  //   height: 100,
                  //   width: 100,
                  //   imageUrl: widget.imageUrl,
                  // ),
                  // height10,
                  // Text(
                  //   'Change profile photo',
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w200,
                  //     color: Theme.of(context).indicatorColor,
                  //     fontFamily: 'sofia',
                  //   ),
                  // ),
                  height20,
                  ProfileAlignedText(
                    title: 'Name',
                  ),
                  height5,
                  ProfileTextFormField(
                    controller: __.name,
                    hintText: 'Name',
                    readOnly: true,
                    enabled: true,
                    onTap: () {
                      __.edited = false;
                      Navigator.of(context).pushNamed(
                        EditNameScreen.routeName,
                        arguments: EditNameScreenArgs(
                          firstname: widget.firstname,
                          surname: widget.surname,
                        ),
                      );
                    },
                  ),
                  // height20,
                  // ProfileAlignedText(
                  //   title: 'Username',
                  // ),
                  // height5,
                  // ProfileTextFormField(
                  //   controller: __.username,
                  //   hintText: 'Username',
                  //   readOnly: true,
                  //   enabled: true,
                  //   onTap: () {
                  //     __.edited = false;
                  //     Navigator.of(context).pushNamed(
                  //       EditUsernameScreen.routeName,
                  //       arguments: EditUsernameScreenArgs(
                  //         username: widget.username,
                  //       ),
                  //     );
                  //   },
                  // ),
                  height20,
                  ProfileAlignedText(
                    title: 'Bio',
                  ),
                  height5,
                  ProfileTextFormField(
                    controller: __.bio,
                    hintText: 'Bio',
                    readOnly: true,
                    enabled: true,
                    onTap: () {
                      __.edited = false;
                      Navigator.of(context).pushNamed(
                        EditBioScreen.routeName,
                        arguments: EditBioScreenArgs(
                          bio: widget.bio,
                        ),
                      );
                    },
                  ),
                  height20,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(
                      'Links',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 15),
                    ),
                    onTap: () {
                      __.edited = false;
                      Navigator.of(context).pushNamed(
                        EditLinksScreen.routeName,
                        arguments: EditLinksScreenArgs(
                          website: widget.website,
                          tiktok: widget.tiktok,
                          instagram: widget.tiktok,
                          youtube: widget.youtube,
                        ),
                      );
                    },
                    trailing: Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  height40,
                  if (__.loading) ...[
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomProgressIndicator(),
                    ),
                  ],
                  if (__.loading == false) ...[
                    TransparentButton(
                      title: 'Update',
                      isBorder: false,
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFA858F4),
                            Color(0xFF9032E6),
                          ],
                          stops: [
                            0.0,
                            1.0
                          ],
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          tileMode: TileMode.repeated),
                      onTap: () async {
                        if (__.selectedImage?.path != null) {
                          final response = await __.uploadImage();
                          if (response == 200 || response == 201) {
                            await user.fetchProfile(
                              username: prefs_username!,
                              forceRefresh: true,
                            );
                          }
                        }

                        final response = await __.updateProfile(context);
                        if (response == 200 || response == 201) {
                          await user.fetchProfile(
                            username: prefs_username!,
                            forceRefresh: true,
                          );
                        }
                      },
                    )
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
