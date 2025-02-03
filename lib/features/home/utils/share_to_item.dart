import 'package:socialverse/export.dart';

class ShareToItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final String label;
  const ShareToItem({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(context).disabledColor,
            child: Center(
              child: Icon(
                icon,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          height5,
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
