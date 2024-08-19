import 'package:socialverse/export.dart';

class HeartPainter extends CustomPainter {
  final double fillPercentage; // Fill percentage from 0 to 100

  HeartPainter({required this.fillPercentage});

  @override
  void paint(Canvas canvas, Size size) {
    // Base paint for the filled part of the heart
    Paint fillPaint = Paint()
      ..color = Color(0xFFFF002A) // Fill color from SVG
      ..style = PaintingStyle.fill;

    // Paint for the heart's outline
    Paint outlinePaint = Paint()
      ..color = Colors.white // Outline color from SVG
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0; // Stroke width from SVG

    // Adjusted path to represent a more traditional heart shape
    Path path = Path();
    path.moveTo(size.width * 0.5,
        size.height * 0.7); // Start at the bottom of the heart
    // Left bezier curve for the top left arc
    path.cubicTo(size.width * 0.1, size.height * 0.5, size.width * 0.2,
        size.height * 0.1, size.width * 0.5, size.height * 0.3);
    // Right bezier curve for the top right arc
    path.cubicTo(size.width * 0.8, size.height * 0.1, size.width * 0.9,
        size.height * 0.5, size.width * 0.5, size.height * 0.7);

    // Closing the path automatically connects the end point to the start point
    path.close();

    // Clipping for fill effect
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    double clipHeight = size.height * (1 - fillPercentage / 100.0);
    canvas.clipRect(Rect.fromLTRB(0, clipHeight, size.width, size.height));
    canvas.drawPath(path, fillPaint);
    canvas.restore();

    // Drawing the outline over the filled path
    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}