import 'package:socialverse/export.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key,
      this.onTap,
      required this.readOnly,
      this.controller,
      this.onChanged,
      this.focusNode,
      this.isFocus = false})
      : super(key: key);

  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool isFocus;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        keyboardType: TextInputType.text,
        readOnly: readOnly,
        onTap: onTap,
        autofocus: true,
        decoration: textFormFieldDecoration.copyWith(
          hintText: 'Search',
          fillColor: Theme.of(context).hoverColor,
          focusedBorder: isFocus
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).hintColor,
                  ), // Border on focus
                )
              : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              AppAsset.icsearch,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          hintStyle: AppTextStyle.displaySmall.copyWith(
            color: Theme.of(context).indicatorColor,
          ),
        ),
        style: Theme.of(context).textTheme.displayMedium,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged,
      ),
    );
  }
}
