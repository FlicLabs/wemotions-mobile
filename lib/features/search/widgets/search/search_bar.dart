import 'package:socialverse/export.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.onTap,
    required this.readOnly,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.isFocus = false,
  }) : super(key: key);

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
        autofocus: isFocus, // Only autofocus when `isFocus` is true
        decoration: _searchInputDecoration(context, isFocus),
        style: Theme.of(context).textTheme.displayMedium,
        textAlignVertical: TextAlignVertical.center,
        onChanged: onChanged != null
            ? _debounce(onChanged!) // Debounce to prevent excessive calls
            : null,
      ),
    );
  }

  /// Extracted function for cleaner code
  InputDecoration _searchInputDecoration(BuildContext context, bool isFocused) {
    return textFormFieldDecoration.copyWith(
      hintText: 'Search',
      fillColor: Theme.of(context).hoverColor,
      focusedBorder: isFocused
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).hintColor,
              ),
            )
          : null,
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14), // Consistent padding
        child: SvgPicture.asset(
          AppAsset.icsearch,
          color: Theme.of(context).indicatorColor,
        ),
      ),
      hintStyle: AppTextStyle.displaySmall.copyWith(
        color: Theme.of(context).indicatorColor,
      ),
    );
  }

  /// Debounce function to optimize `onChanged` calls
  Function(String) _debounce(void Function(String) callback, {Duration duration = const Duration(milliseconds: 300)}) {
    Timer? timer;
    return (String value) {
      timer?.cancel();
      timer = Timer(duration, () => callback(value));
    };
  }
}
