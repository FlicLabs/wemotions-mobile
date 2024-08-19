import 'package:socialverse/export.dart';

class LinkSheetItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String link;
  final IconData icon;
  const LinkSheetItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.link,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).disabledColor,
            radius: 22,
            child: Icon(
              icon,
              color: Theme.of(context).focusColor,
              size: 18,
            ),
          ),
          width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 15, overflow: TextOverflow.ellipsis),
                ),
                Text(
                  link,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
