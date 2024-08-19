import 'package:socialverse/export.dart';

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 60,
        damping: 1,
      );

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // This checks if you're overscrolling at the top
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    // This checks if you're overscrolling at the bottom
    if (value > position.pixels &&
        position.pixels >= position.maxScrollExtent) {
      return value - position.pixels;
    }
    // Returning 0.0 here effectively turns off the bounce effect at the edges
    return 0.0;
  }
}
