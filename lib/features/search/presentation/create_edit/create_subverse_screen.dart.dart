import 'package:socialverse/export.dart';

class CreateSubverseScreen extends StatelessWidget {
  static const String routeName = '/create-subverse';
  const CreateSubverseScreen({super.key});

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => CreateSubverseScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateSubverseProvider>(builder: (_, __, ___) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Subverse',
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
                  SubverseAlignedText(
                    title: 'Title',
                  ),
                  height5,
                  SubverseTextFormField(
                    controller: __.title,
                    hintText: 'Title of Your Subverse',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter subverse title';
                      }
                      return null;
                    },
                  ),
                  height20,
                  SubverseAlignedText(
                    title: 'Description',
                  ),
                  height5,
                  SubverseTextFormField(
                    controller: __.description,
                    hintText: 'Description of Your Subverse',
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
                    ImageTextButton(
                      title: 'Create Subverse',
                      onTap: () {
                        if (__.formKey.currentState!.validate()) {
                          __.createSubverse(context);
                        }
                      },
                    ),
                    if (__.loading) ...[
                      CustomProgressIndicator(),
                    ]
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
