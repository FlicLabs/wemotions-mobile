import 'package:socialverse/export.dart';

class SearchBar extends StatelessWidget {
  SearchBar(
      {Key? key,
      this.onTap,
      required this.readOnly,
      this.controller,
      this.onChanged,
      this.prefixIcon = false,
      this.focusNode})
      : super(key: key);

  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool prefixIcon;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: TextInputType.text,
      readOnly: readOnly,
      onTap: onTap,
      autofocus: true,
      decoration: textFormFieldDecoration.copyWith(
        hintText: 'Search',
        fillColor: Theme.of(context).hoverColor,
        focusedBorder: readOnly
            ? null
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).hintColor,
                ),
              ),
        enabledBorder: readOnly
            ? null
            : OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).indicatorColor),
              ),
        prefixIcon: prefixIcon
            ? Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                  AppAsset.icsearch,
                  color: Theme.of(context).indicatorColor,
                ),
              )
            : const SizedBox.shrink(),
        suffixIcon: prefixIcon == false
            ? Padding(
                padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                  AppAsset.icsearch,
                  color: Theme.of(context).indicatorColor,
                ),
              )
            : const SizedBox.shrink(),
        hintStyle: AppTextStyle.displaySmall.copyWith(
          color: Theme.of(context).indicatorColor,
        ),
      ),
      style: Theme.of(context).textTheme.displayMedium,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
    );
  }
}
