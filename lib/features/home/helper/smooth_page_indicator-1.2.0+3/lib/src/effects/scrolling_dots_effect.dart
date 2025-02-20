import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/src/painters/scrolling_dots_painter.dart';
import 'indicator_effect.dart';

class ScrollingDotsEffect extends BasicIndicatorEffect {
  final double activeStrokeWidth;
  final double activeDotScale;
  final int maxVisibleDots;
  final bool fixedCenter;

  const ScrollingDotsEffect({
    this.activeStrokeWidth = 1.5,
    this.activeDotScale = 1.3,
    this.maxVisibleDots = 3,
    this.fixedCenter = false,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
  })  : assert(activeDotScale >= 0.0 && maxVisibleDots >= 3),
        super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  @override
  Size calculateSize(int count) {
    double width = (dotWidth + spacing) * min(count, maxVisibleDots);
    return Size(width, dotHeight * activeDotScale);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    int firstVisibleDot = max(0, current.floor() - (maxVisibleDots ~/ 2));
    int lastVisibleDot = min(firstVisibleDot + maxVisibleDots, count - 1);
    double offset = 0.0;

    for (var index = firstVisibleDot; index <= lastVisibleDot; index++) {
      if (dx <= (offset += dotWidth + spacing)) return index;
    }
    return -1;
  }

  @override
  BasicIndicatorPainter buildPainter(int count, double offset) {
    return ScrollingDotsPainter(count: count, offset: offset, effect: this);
  }
}
