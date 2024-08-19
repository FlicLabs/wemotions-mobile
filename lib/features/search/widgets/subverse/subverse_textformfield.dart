import 'package:socialverse/export.dart';

class SubverseTextFormField extends StatelessWidget {
  const SubverseTextFormField({
    Key? key,
    this.onTap,
    this.controller,
    this.validator,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.maxLength,
  }) : super(key: key);

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      onTap: onTap,
      enabled: enabled ?? true,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      decoration: textFormFieldDecoration.copyWith(
        hintText: hintText,
        fillColor: Theme.of(context).hoverColor,
        hintStyle: AppTextStyle.displaySmall.copyWith(
          color: Theme.of(context).indicatorColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 13),
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
    );
  }
}
