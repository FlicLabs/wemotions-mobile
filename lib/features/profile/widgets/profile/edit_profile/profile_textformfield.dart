import 'package:socialverse/export.dart';

class ProfileTextFormField extends StatelessWidget {
  const ProfileTextFormField({
    Key? key,
    this.onTap,
    this.controller,
    this.validator,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.autofocus,
    this.onChanged,
    this.maxLength,
    this.onEditingComplete,
  }) : super(key: key);

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final bool? autofocus;
  final int? maxLength;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      onTap: onTap,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      enabled: enabled,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      onEditingComplete: onEditingComplete,
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
