import 'package:socialverse/export.dart';
import 'package:socialverse/features/home/utils/heart_painter.dart';

class CustomHeartWidget extends StatelessWidget {
  final double fillPercentage; // 0 to 100

  const CustomHeartWidget({Key? key, required this.fillPercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HeartPainter(fillPercentage: fillPercentage),
      size: Size(80, 80), // Adjust size as needed
    );
  }
}