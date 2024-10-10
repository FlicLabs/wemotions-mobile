import 'package:socialverse/export.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.label,
    this.trailing, this.textStyle,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final Widget? trailing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 1,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      title: Text(
        label,
        style: textStyle?? AppTextStyle.normalBold18
            .copyWith(color: Theme.of(context).focusColor.withOpacity(0.8)),
      ),
      trailing: trailing ??
          Icon(
            Icons.keyboard_arrow_right_sharp,
            color: Theme.of(context).focusColor,
          ),
    );
  }
}
