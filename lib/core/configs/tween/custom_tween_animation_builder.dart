import 'package:flutter/material.dart';

class CustomTweenAnimation extends StatelessWidget {
  final double begin;
  final double end;
  final Widget child;
  const CustomTweenAnimation({
    required this.begin,
    required this.end,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: begin, end: end),
      duration: Duration(milliseconds: 1800),
      builder: (context, double size, child) {
        return Transform.scale(scale: size, child: child);
      },
      child: child,
    );
  }
}
