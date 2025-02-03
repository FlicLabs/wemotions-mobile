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
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap,
      onTapDown: onTapDown,
      child: Column(
        children: [
          Container(
            child: icon,
            decoration: BoxDecoration(color: Colors.transparent),
          ),
          height2,
          text,
        ],
      ),
    );
  }
}
