import 'package:socialverse/export.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.onTap,
    this.onLongPress,
    this.onLongPressEnd,
    this.color, 
    this.icon = Icons.arrow_forward_ios_rounded, 
    this.iconSize = 17, 
  }) : super(key: key);

  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final void Function(LongPressEndDetails)? onLongPressEnd;
  final Color? color;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onLongPressEnd: onLongPressEnd,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
