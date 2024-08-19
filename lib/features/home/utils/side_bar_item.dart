import 'package:socialverse/export.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.value,
    required this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onTapDown,
  }) : super(key: key);

  final Widget icon;
  final Widget text;
  final double value;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final Function(TapDownDetails)? onTapDown;

  @override
  Widget build(BuildContext context) {
    final VideoProvider video = Provider.of<VideoProvider>(context);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      onTapDown: onTapDown,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.10),
            ),
            padding: EdgeInsets.all(value),
            child: icon,
          ),
          video.isViewMode ? shrink : height2,
          text,
        ],
      ),
    );
  }
}
