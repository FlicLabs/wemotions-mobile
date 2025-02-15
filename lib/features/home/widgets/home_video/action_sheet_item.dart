import 'package:socialverse/export.dart';

class ActionSheetItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String? svg;
  final IconData? icon;
  final Color? color;

  const ActionSheetItem({
    Key? key,
    required this.onTap,
    required this.label,
    this.icon,
    this.color,
    this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).indicatorColor;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (svg != null)
            SvgPicture.asset(
              svg!,
              height: 20,
              width: 20,
              color: iconColor,
            )
          else if (icon != null)
            Icon(
              icon,
              color: iconColor,
            ),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
