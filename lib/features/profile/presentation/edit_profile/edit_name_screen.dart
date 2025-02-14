import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/export.dart';

class EditNameScreenArgs {
  final String firstname;
  final String surname;

  const EditNameScreenArgs({
    required this.firstname,
    required this.surname,
  });
}

class EditNameScreen extends StatefulWidget {
  static const String routeName = '/edit-name';

  final String firstname;
  final String surname;

  const EditNameScreen({
    Key? key,
    required this.firstname,
    required this.surname,
  }) : super(key: key);

  static Route route({required EditNameScreenArgs args}) {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => EditNameScreen(
        firstname: args.firstname,
        surname: args.surname,
      ),
    );
  }

  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  late TextEditingController _firstnameController;
  late TextEditingController _surnameController;
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.firstname);
    _surnameController = TextEditingController(text: widget.surname);

    _firstnameController.addListener(_updateEditState);
    _surnameController.addListener(_updateEditState);
  }

  void _updateEditState() {
    setState(() {
      isEdited = _firstnameController.text.trim() != widget.firstname.trim() ||
          _surnameController.text.trim() != widget.surname.trim();
    });
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Name',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.start,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: SaveButton(
              onTap: isEdited
                  ? () {
                      editProfileProvider.updateName(
                        firstname: _firstnameController.text.trim(),
                        surname: _surnameController.text.trim(),
                      );
                      Navigator.of(context).pop();
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
            _buildTextField(title: 'First Name', controller: _firstnameController),
            _buildTextField(title: 'Last Name', controller: _surnameController),
          ],
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

