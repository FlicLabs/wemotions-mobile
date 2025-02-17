import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/export.dart';

class EditBioScreenArgs {
  final String bio;
  const EditBioScreenArgs({required this.bio});
}

class EditBioScreen extends StatefulWidget {
  static const String routeName = '/edit-bio';

  final String bio;
  const EditBioScreen({Key? key, required this.bio}) : super(key: key);

  static Route route({required EditBioScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => EditBioScreen(bio: args.bio),
    );
  }

  @override
  _EditBioScreenState createState() => _EditBioScreenState();
}

class _EditBioScreenState extends State<EditBioScreen> {
  late TextEditingController _bioController;
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.bio);
    _bioController.addListener(() {
      setState(() {
        isEdited = _bioController.text.trim() != widget.bio.trim();
      });
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Bio',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: SaveButton(
              onTap: isEdited
                  ? () {
                      editProfileProvider.updateBio(_bioController.text.trim());
                      Navigator.of(context).pop();
                    }
                  : null,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileAlignedText(title: 'Bio'),
            const SizedBox(height: 5),
            ProfileTextFormField(
              controller: _bioController,
              hintText: 'Enter your bio...',
              maxLines: 2,
              enabled: true,
              autofocus: true,
              maxLength: 130,
            ),
          ],
        ),
      ),
    );
  }
}
