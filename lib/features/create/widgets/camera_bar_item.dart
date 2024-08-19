import 'package:socialverse/export.dart';

class CameraBarItem extends StatelessWidget {
  const CameraBarItem(
      {Key? key, required this.onTap, required this.label, required this.icon})
      : super(key: key);

  final VoidCallback onTap;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        return Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: label == 'Timer'
                      ? __.is_timer_on == true
                          ? Colors.black.withOpacity(0.50)
                          : Colors.white.withOpacity(0.10)
                      : label == 'Flash'
                          ? __.is_camera_flash_on == true
                              ? Colors.black.withOpacity(0.50)
                              : Colors.white.withOpacity(0.10)
                          : Colors.white.withOpacity(0.10),
                ),
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  icon,
                  height: 25,
                ),
              ),
            ),
            height5,
            Text(
              label,
              style: AppTextStyle.normalBold14.copyWith(color: Colors.white),
            ),
          ],
        );
      },
    );
  }
}
