import 'package:socialverse/export.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    super.key,
    this.onTap,
    this.controller,
    this.validator,
    this.hintText,
    this.readOnly,
    this.enabled,
    this.maxLines,
    this.maxLength,
    this.obscureText,
    this.autofocus,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
  });

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? hintText;
  final bool? readOnly;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? autofocus;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      decoration: textFormFieldDecoration.copyWith(
        hintText: hintText,
        fillColor: Theme.of(context).hoverColor,
        hintStyle: AppTextStyle.displaySmall.copyWith(
          color: Theme.of(context).indicatorColor,
        ),
        errorStyle:
            Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 13),
      validator: validator,
    );
  }
}
