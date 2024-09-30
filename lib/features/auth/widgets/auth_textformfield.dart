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
    this.fillColor
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
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // expands: true,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      autofocus: autofocus ?? false,
      obscureText: obscureText ?? false,
      decoration: textFormFieldDecoration.copyWith(
        hintText: hintText,
        fillColor: fillColor != null ? fillColor : Theme.of(context).primaryColor,
        hintStyle: AppTextStyle.displaySmall.copyWith(
          color: Colors.grey.shade500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7C7C7C)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7C7C7C)),
        ),
        // Error style
        errorStyle: TextStyle(
          color: Colors.transparent, // Hide default error message
          fontSize: 0,
          height: 0// Set font size to 0 to hide
        ),
        // errorStyle:
        //     Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12,color: Colors.red),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFA858F4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade600),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade600),
        ),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 13),
      validator: validator,
    );
  }
}
