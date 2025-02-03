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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Theme.of(context).indicatorColor,
            size: 24,
          ),
          width16,
          Text(
            label,
            style:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class VideoSheetItemSVG extends StatelessWidget {
  final VoidCallback onTap;
  final SvgPicture iconSVG;
  final String label;

  const VideoSheetItemSVG({
    Key? key,
    required this.onTap,
    required this.iconSVG,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          iconSVG,
          width16,
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
