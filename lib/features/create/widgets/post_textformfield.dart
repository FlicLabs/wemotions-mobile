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
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height / 5,
      width: size.width,
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
          hintText: 'Enter your description here please',
          fillColor: Colors.transparent,
          hintStyle: AppTextStyle.displaySmall.copyWith(
            color: Colors.grey.shade500,
          ),
          enabledBorder: _borderStyle(const Color(0xFF7C7C7C)),
          disabledBorder: _borderStyle(const Color(0xFF7C7C7C)),
          focusedBorder: _borderStyle(const Color(0xFFA858F4)),
          errorBorder: _borderStyle(Colors.red.shade600),
          focusedErrorBorder: _borderStyle(Colors.red.shade600),
          errorStyle: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 12, color: Colors.red),
        ),
        onChanged: onChanged,
        validator: (value) => (value == null || value.trim().isEmpty)
            ? 'Please enter a caption'
            : null,
      ),
    );
  }

  OutlineInputBorder _borderStyle(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}
