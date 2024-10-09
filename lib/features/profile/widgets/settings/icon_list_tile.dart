import 'package:socialverse/export.dart';

class IconListTile extends StatelessWidget {
  const IconListTile({
    Key? key,
    required this.onTap,
    required this.label,
    this.trailing,
    this.svg,
    this.leading,
    this.color,
    this.height,
    this.width,
    this.textStyle,
  }) : super(key: key);

  final VoidCallback onTap;
  final String? svg;
  final String label;
  final Widget? trailing;
  final Widget? leading;
  final Color? color;
  final double? height;
  final double? width;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 1,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      leading: leading ??
          SvgPicture.asset(
            svg!,
            height: height ?? 23,
            width: width ?? 23,
            color: color ?? Colors.grey,
            fit: BoxFit.cover,
          ),
      title: Text(
        label,
        style: textStyle ??
            AppTextStyle.normalBold18
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
