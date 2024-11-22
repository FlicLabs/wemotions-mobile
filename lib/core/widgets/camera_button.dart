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
      percent: 1,
      progressColor: isDark ? Colors.white : Color(0xFFA858F4),
      animation: true,
      addAutomaticKeepAlive: true,
      animationDuration: 0,
      animateFromLastPercent: true,
      center: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFA858F4),
                    Color(0xFF9032E6),
                  ],
                  stops: [
                    0.0,
                    1.0
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  tileMode: TileMode.repeated),
            ),
          ),
          Container(
            child: nav.selectedVideoUploadType == "Video"
                ? SvgPicture.asset(AppAsset.icvideopost)
                : SvgPicture.asset(AppAsset.icreply),
          ),
        ],
      ),
    );
  }
}
