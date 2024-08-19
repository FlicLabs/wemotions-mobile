import 'package:socialverse/export.dart';

class PostTextFormField extends StatelessWidget {
  const PostTextFormField({
    Key? key,
    this.onTap,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cs().height(context) / 5,
      width: cs().width(context) / 1.65,
      child: TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.start,
        onTap: onTap,
        decoration: textFormFieldDecoration.copyWith(
          hintText: 'Write a caption...',
          fillColor: Theme.of(context).hoverColor,
          errorStyle:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 10),
        ),
        style: Theme.of(context).textTheme.displayMedium,
        onChanged: onChanged,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a caption';
          }
          return null;
        },
      ),
    );
  }
}
