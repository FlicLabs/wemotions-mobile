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
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      keyboardType: TextInputType.text,
      onTap: onTap,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      enabled: enabled??true,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      onEditingComplete: onEditingComplete,
      decoration: textFormFieldDecoration.copyWith(
        hintText: hintText,
        fillColor: Theme.of(context).primaryColor,
        hintStyle: AppTextStyle.displaySmall.copyWith(
          color: Colors.grey.shade500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF7C7C7C)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2)),
        ),
        // Error style
        errorStyle: TextStyle(
            color: Colors.transparent, // Hide default error message
            fontSize: 0,
            height: 0 // Set font size to 0 to hide
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
      ),
      style: enabled == true
          ? Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 13)
          : Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 13,
              color: Theme.of(context).focusColor.withOpacity(0.2)),
      textAlignVertical: TextAlignVertical.center,
      validator: validator,
    );
  }
}
