import 'package:socialverse/export.dart';

class EditSubverseScreenArgs {
  final int id;
  final String name;
  final String imageUrl;
  final String? description;

  const EditSubverseScreenArgs({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
  });
}

class EditSubverseScreen extends StatefulWidget {
  static const String routeName = '/edit-subverse';
  const EditSubverseScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
  }) : super(key: key);

  final int id;
  final String name;
  final String imageUrl;
  final String? description;

  static Route route({required EditSubverseScreenArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => EditSubverseScreen(
        name: args.name,
        id: args.id,
        description: args.description,
        imageUrl: args.imageUrl,
      ),
    );
  }

  @override
  State<EditSubverseScreen> createState() => _EditSubverseScreenState();
}

class _EditSubverseScreenState extends State<EditSubverseScreen> {
  @override
  void didChangeDependencies() {
    final edit = Provider.of<EditSubverseProvider>(context, listen: false);
    edit.selectedImage = null;
    edit.description.text = widget.description!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditSubverseProvider>(builder: (_, __, ___) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Edit Subverse',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: __.formKey,
              child: Column(
                children: [
                  if (__.selectedImage?.path == null) ...[
                    GestureDetector(
                      onTap: () async {
                        await __.selectSubversePhoto(context);
                        // var e = PlatformException(code: 'photo_access_denied');
                        // if (e.code == 'photo_access_denied') {
                        //   openAppSettings();
                        // }
                      },
                      child: Column(
                        children: [
                          if (widget.imageUrl.isEmpty) ...[
                            Image.asset(
                              AppAsset.imagePicker,
                              height: 200,
                              width: 200,
                            ),
                            height10,
                            Text(
                              'Tap to add Subverse photo',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            )
                          ],
                          if (widget.imageUrl.isNotEmpty) ...[
                            CustomCachedNetworkImage(
                              imageUrl: widget.imageUrl,
                              height: 200,
                              width: 200,
                            ),
                            height10,
                            Text(
                              'Tap to add Subverse photo',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ],
                      ),
                    ),
                  ],
                  if (__.selectedImage?.path != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        File(__.selectedImage!.path),
                        height: 200,
                        fit: BoxFit.cover,
                        width: 200,
                      ),
                    )
                  ],
                  height60,
                  SubverseAlignedText(
                    title: 'Title',
                  ),
                  height5,
                  SubverseTextFormField(
                    hintText: widget.name,
                    readOnly: true,
                    enabled: false,
                  ),
                  height20,
                  SubverseAlignedText(
                    title: 'Description',
                  ),
                  height5,
                  SubverseTextFormField(
                    controller: __.description,
                    hintText: 'Enter description',
                    maxLines: 2,
                    maxLength: 90,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter subverse description';
                      }
                      return null;
                    },
                  ),
                  height40,
                  if (__.loading == false) ...[
                    TransparentButton(
                      title: 'Update Subverse',
                      onTap: () async {
                        if (__.formKey.currentState!.validate()) {
                          switch (__.selectedImage?.path == null) {
                            case false:
                              await [
                                __.uploadImage(context, id: widget.id),
                                __.updateDescription(context, id: widget.id),
                              ];
                              break;
                            case true:
                              __.updateDescription(context, id: widget.id);
                              break;
                          }
                        }
                      },
                    ),
                    if (__.loading == true) ...[
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CustomProgressIndicator(),
                      ),
                    ]
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
