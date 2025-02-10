import 'package:flutter/material.dart';

class VideoScrollPhysics extends ScrollPhysics {
  const VideoScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  VideoScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return VideoScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 0.5, // Reduced mass for faster response
    stiffness: 200.0, // Increased stiffness for snappier movement
    damping: 20.0, // Adjusted damping for smooth deceleration
  );

  @override
  double get dragStartDistanceMotionThreshold => 3.0;

  @override
  double get minFlingVelocity => 50.0;

  @override
  double get maxFlingVelocity => 8000.0;

  @override
  double get minFlingDistance => 3.0;

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;

    // Page height is our target
    final double pageHeight = position.viewportDimension;

    // Current scroll position
    final double currentPixels = position.pixels;

    // Determine target page based on velocity and current position
    double targetPixels;
    if (velocity.abs() > minFlingVelocity) {
      targetPixels = velocity > 0
          ? (currentPixels / pageHeight).ceil() * pageHeight
          : (currentPixels / pageHeight).floor() * pageHeight;
    } else {
      targetPixels = (currentPixels / pageHeight).round() * pageHeight;
    }

    // If we're already at the target, no simulation needed
    if (targetPixels == currentPixels) {
      return null;
    }

    // Calculate simulation duration based on velocity
    final int durationMilliseconds = (500 * (1 - (velocity.abs() / maxFlingVelocity))).round();
    final duration = Duration(milliseconds: durationMilliseconds.clamp(200, 500));

    return ScrollSpringSimulation(
      spring,
      currentPixels,
      targetPixels,
      velocity,
      tolerance: tolerance,
    )..tolerance = tolerance;
  }

  @override
  bool get allowImplicitScrolling => false;
}
