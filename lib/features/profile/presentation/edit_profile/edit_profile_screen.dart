import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileProvider editProvider;
  late ProfileProvider userProvider;

  @override
  void initState() {
    super.initState();
    editProvider = Provider.of<EditProfileProvider>(context, listen: false);
    userProvider = Provider.of<ProfileProvider>(context, listen: false);

    _initializeFields();
  }

  void _initializeFields() {
    final user = userProvider.user;
    editProvider.username.text = user.username;
    editProvider.name.text = user.name;
    editProvider.bio.text = user.bio;
    editProvider.firstname.text = user.firstName;
    editProvider.surname.text = user.lastName;
    editProvider.website.text = user.website;
    editProvider.tiktok.text = user.tiktokUrl;
    editProvider.instagram.text = user.instagramUrl;
    editProvider.youtube.text = user.youtubeUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImageSection(__),
                const SizedBox(height: 20),
                _buildEditableField(
                  title: 'Name',
                  controller: __.name,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      EditNameScreen.routeName,
                      arguments: EditNameScreenArgs(
                        firstname: widget.firstname,
                        surname: widget.surname,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildEditableField(
                  title: 'Bio',
                  controller: __.bio,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      EditBioScreen.routeName,
                      arguments: EditBioScreenArgs(bio: widget.bio),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildLinksSection(),
                const SizedBox(height: 40),
                _buildUpdateButton(__),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImageSection(EditProfileProvider provider) {
    return GestureDetector(
      onTap: () async => await provider.selectProfilePhoto(context),
      child: Column(
        children: [
          if (widget.imageUrl.isEmpty && provider.selectedImage?.path == null)
            Column(
              children: [
                SvgPicture.asset(AppAsset.icuser, height: 100, width: 100),
                const SizedBox(height: 10),
                Text(
                  'Tap to add Subverse photo',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          if (widget.imageUrl.isNotEmpty && provider.selectedImage?.path == null)
            CustomCircularAvatar(imageUrl: widget.imageUrl, height: 100, width: 100),
          if (provider.selectedImage?.path != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                File(provider.selectedImage!.path),
                height: 100,
                fit: BoxFit.cover,
                width: 100,
              ),
            ),
          const SizedBox(height: 10),
          Text(
            'Change profile photo',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w200,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String title,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAlignedText(title: title),
        const SizedBox(height: 5),
        ProfileTextFormField(
          controller: controller,
          hintText: title,
          readOnly: true,
          enabled: true,
          onTap: onTap,
        ),
      ],
    );
  }

  Widget _buildLinksSection() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text(
        'Links',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 15),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          EditLinksScreen.routeName,
          arguments: EditLinksScreenArgs(
            website: widget.website,
            tiktok: widget.tiktok,
            instagram: widget.instagram,
            youtube: widget.youtube,
          ),
        );
      },
      trailing: Icon(
        Icons.keyboard_arrow_right_sharp,
        color: Theme.of(context).focusColor,
      ),
    );
  }

  Widget _buildUpdateButton(EditProfileProvider provider) {
    return provider.loading
        ? const SizedBox(
            height: 50,
            width: 50,
            child: CustomProgressIndicator(),
          )
        : TransparentButton(
            title: 'Update',
            isBorder: false,
            gradient: const LinearGradient(
              colors: [Color(0xFFA858F4), Color(0xFF9032E6)],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
            onTap: () async {
              if (provider.selectedImage?.path != null) {
                final response = await provider.uploadImage();
                if (response == 200 || response == 201) {
                  await userProvider.fetchProfile(
                    username: prefs_username!,
                    forceRefresh: true,
                  );
                }
              }

              final response = await provider.updateProfile(context);
              if (response == 200 || response == 201) {
                await userProvider.fetchProfile(
                  username: prefs_username!,
                  forceRefresh: true,
                );
              }
            },
          );
  }
}

