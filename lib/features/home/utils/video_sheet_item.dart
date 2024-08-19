import 'package:socialverse/export.dart';

class VideoSheetItem extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final Color? color;
  const VideoSheetItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.icon,
    this.color,
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
            backgroundColor: color ?? Theme.of(context).disabledColor,
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
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class VideoSheetItemSVG extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const VideoSheetItemSVG({
    Key? key,
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
              child: Image.asset(
                AppAsset.v,
                height: 18,
                width: 18,
                color: Theme.of(context).focusColor,
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
