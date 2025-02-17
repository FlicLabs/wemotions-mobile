import 'package:socialverse/export.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
    required this.isDark,
    required this.nav,
  });

  final bool isDark;
  final BottomNavBarProvider nav;

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = const LinearGradient(
      colors: [Color(0xFFA858F4), Color(0xFF9032E6)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return CircularPercentIndicator(
      radius: 35,
      lineWidth: 4.0,
      backgroundColor: Colors.white,
      percent: 1.0,
      progressColor: isDark ? Colors.white : const Color(0xFFA858F4),
      animateFromLastPercent: false, // Removed unnecessary animation
      center: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
            ),
          ),
          SvgPicture.asset(
            nav.selectedVideoUploadType == "Video"
                ? AppAsset.icvideopost
                : AppAsset.icreply,
          ),
        ],
      ),
    );
  }
}
