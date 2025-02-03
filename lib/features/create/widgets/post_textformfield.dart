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
      height: cs.height(context) / 5,
      width: cs.width(context),
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
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF7C7C7C)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF7C7C7C)),
          ),
          // Error style
          // errorStyle: TextStyle(
          //     color: Colors.transparent, // Hide default error message
          //     fontSize: 0,
          //     height: 0// Set font size to 0 to hide
          // ),
          errorStyle:
              Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12,color: Colors.red),
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
        // style: Theme.of(context).textTheme.displayMedium,
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
