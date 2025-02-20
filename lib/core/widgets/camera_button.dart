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
    return CircularPercentIndicator(
      radius: 35,
      lineWidth: 4.0,
      backgroundColor: Colors.white,
      percent: 1.0,
      progressColor: isDark ? Colors.white : const Color(0xFFA858F4),
      animation: true,
      animateFromLastPercent: true,
      center: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFA858F4), Color(0xFF9032E6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
