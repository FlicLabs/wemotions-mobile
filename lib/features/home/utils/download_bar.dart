import 'package:socialverse/export.dart';

class DownloadBar extends StatelessWidget {
  const DownloadBar({
    Key? key,
    required this.label,
    required this.color,
    this.height,
  }) : super(key: key);

  final String label;
  final Color color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 3,
      child: Container(
        height: 28,
        width: cs().width(context),
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 3,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.normalBold12.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
