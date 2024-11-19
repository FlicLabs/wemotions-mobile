import 'package:socialverse/export.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
    this.onTap,
    required this.readOnly,
    this.controller,
    this.onChanged,
    this.prefixIcon = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  bool prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      readOnly: readOnly,
      onTap: onTap,
      autofocus: true,
      decoration: textFormFieldDecoration.copyWith(
        hintText: 'Search',
        fillColor: Theme.of(context).hoverColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).indicatorColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
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
