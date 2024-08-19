import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveSliderTrackShape extends SliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    Offset? secondaryOffset,
    double additionalActiveTrackHeight = 2,
  }) {
    final Paint activePaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!;

    const height = 20.0;
    final width = parentBox.size.width;

    Path path = Path();
    for (double i = 0; i <= width; i++) {
      path.lineTo(
        i,
        math.sin((i / width * 2 * math.pi) +
                    thumbCenter.dx / width * 2 * math.pi) *
                height +
            offset.dy,
      );
    }

    context.canvas.drawPath(path, inactivePaint);

    Path activePath = Path();
    for (double i = 0; i <= thumbCenter.dx; i++) {
      activePath.lineTo(
        i,
        math.sin((i / width * 2 * math.pi) +
                    thumbCenter.dx / width * 2 * math.pi) *
                height +
            offset.dy,
      );
    }

    context.canvas.drawPath(activePath, activePaint);
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class RainbowTrackShape extends SliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    Offset? secondaryOffset,
    double additionalActiveTrackHeight = 2,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Calculate the radius for rounded corners
    final double radius = trackRect.height / 2.0;

    final Paint activePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
        ],
      ).createShader(trackRect);

    // Create a rounded rectangle
    final RRect roundedRect = RRect.fromRectAndRadius(
      trackRect,
      Radius.circular(radius),
    );

    context.canvas.drawRRect(roundedRect, activePaint);
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx +
        sliderTheme.thumbShape!.getPreferredSize(false, false).width / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackRight = parentBox.size.width - trackLeft;
    final double trackBottom = trackTop + trackHeight;

    return Rect.fromLTRB(trackLeft, trackTop, trackRight, trackBottom);
  }
}
