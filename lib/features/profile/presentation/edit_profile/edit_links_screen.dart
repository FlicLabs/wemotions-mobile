import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class EditLinksScreen extends StatefulWidget {
  static const String routeName = '/edit-links';

  final String website;
  final String instagram;
  final String tiktok;
  final String youtube;

  const EditLinksScreen({
    Key? key,
    required this.website,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
  }) : super(key: key);

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
  _EditLinksScreenState createState() => _EditLinksScreenState();
}

class _EditLinksScreenState extends State<EditLinksScreen> {
  late TextEditingController _websiteController;
  late TextEditingController _instagramController;
  late TextEditingController _tiktokController;
  late TextEditingController _youtubeController;

  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    _websiteController = TextEditingController(text: widget.website);
    _instagramController = TextEditingController(text: widget.instagram);
    _tiktokController = TextEditingController(text: widget.tiktok);
    _youtubeController = TextEditingController(text: widget.youtube);

    _websiteController.addListener(_updateEditState);
    _instagramController.addListener(_updateEditState);
    _tiktokController.addListener(_updateEditState);
    _youtubeController.addListener(_updateEditState);
  }

  void _updateEditState() {
    setState(() {
      isEdited = _websiteController.text.trim() != widget.website.trim() ||
          _instagramController.text.trim() != widget.instagram.trim() ||
          _tiktokController.text.trim() != widget.tiktok.trim() ||
          _youtubeController.text.trim() != widget.youtube.trim();
    });
  }

  @override
  void dispose() {
    _websiteController.dispose();
    _instagramController.dispose();
    _tiktokController.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Edit Links',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: SaveButton(
                onTap: isEdited
                    ? () async {
                        editProfileProvider.setLoading(true);
                        int response = await editProfileProvider.updateLinks(
                          website: _websiteController.text.trim(),
                          instagram: _instagramController.text.trim(),
                          tiktok: _tiktokController.text.trim(),
                          youtube: _youtubeController.text.trim(),
                        );
                        if (response == 200 || response == 201) {
                          await profileProvider.fetchProfile(
                            username: prefs_username!,
                            forceRefresh: true,
                          );
                          Navigator.of(context).pop();
                        }
                        editProfileProvider.setLoading(false);
                      }
                    : null, // Disable button if no changes
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(title: 'Website', controller: _websiteController),
              _buildTextField(title: 'Instagram', controller: _instagramController),
              _buildTextField(title: 'Tiktok', controller: _tiktokController),
              _buildTextField(title: 'Youtube', controller: _youtubeController),
              const SizedBox(height: 40),
              if (editProfileProvider.loading)
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
  }

  Widget _buildTextField({required String title, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAlignedText(title: title),
        const SizedBox(height: 5),
        ProfileTextFormField(
          controller: controller,
          hintText: title,
          enabled: true,
          autofocus: false,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

