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
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onLongPressEnd: onLongPressEnd,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).hintColor,
        ),
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
