import 'package:socialverse/export.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    required this.onTap,
    this.onLongPress,
    this.onLongPressEnd,
  }) : super(key: key);

  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final void Function(LongPressEndDetails)? onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onLongPressEnd: onLongPressEnd,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(shape: BoxShape.circle,
              color: Color(0xFFA858F4),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }
}
