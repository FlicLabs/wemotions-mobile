import 'package:socialverse/export.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.label,
    this.trailing,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 1,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      title: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      trailing: trailing ??
          Icon(
            Icons.keyboard_arrow_right_sharp,
            color: Theme.of(context).focusColor,
          ),
    );
  }
}
