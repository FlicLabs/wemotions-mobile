import 'package:socialverse/export.dart';

class DescBar extends StatelessWidget {
  const DescBar({
    Key? key,
    this.onTap,
    required this.controller, // Ensures controller is always passed
    this.onChanged,
    this.hintText = 'Enter description...', // Default hint text
  }) : super(key: key);

  final VoidCallback? onTap;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cs().height(context) / 5,
      width: cs().width(context) / 1.65,
      child: TextField(
        expands: true,
        maxLines: null,
        minLines: null,
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.start,
        onTap: onTap,
        decoration: textFormFieldDecoration.copyWith(
          hintText: hintText,
          fillColor: Theme.of(context).hoverColor,
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).hintColor,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: onChanged,
      ),
    );
  }
}
