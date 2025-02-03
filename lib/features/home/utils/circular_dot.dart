import 'package:socialverse/export.dart';

class CircularDot extends StatelessWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final Color clr;
  final bool onFocus;
  const CircularDot({required this.horizontalPadding,required this.verticalPadding,required this.clr,required this.onFocus,super.key});


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.bounceInOut,
      width: onFocus?12:9,
      height: onFocus?12:9,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: clr,
      ),
    );
  }
}
