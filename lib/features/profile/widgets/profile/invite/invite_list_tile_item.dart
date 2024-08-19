import 'package:socialverse/export.dart';

class InviteTileItem extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String label;
  const InviteTileItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Theme.of(context).hintColor,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right_sharp,
        color: Theme.of(context).focusColor,
      ),
    );
  }
}

class InviteTileItemSVG extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final String label;
  const InviteTileItemSVG({
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
