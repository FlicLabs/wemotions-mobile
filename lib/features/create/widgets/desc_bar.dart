import 'package:socialverse/export.dart';

class DescBar extends StatelessWidget {
  const DescBar({
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
          hintText: '',
          fillColor: Theme.of(context).hoverColor,
          hintStyle: AppTextStyle.displaySmall.copyWith(
            color: Theme.of(context).indicatorColor,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        style: Theme.of(context).textTheme.displayMedium,
        onChanged: onChanged,
      ),
    );
  }
}
