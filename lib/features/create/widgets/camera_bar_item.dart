import 'package:socialverse/export.dart';

class CameraBarItem extends StatelessWidget {
  const CameraBarItem(
      {Key? key, required this.onTap, required this.label, required this.icon, required this.iconColor})
      : super(key: key);

  final VoidCallback onTap;
  final String label;
  final String icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        return Column(
          children: [
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                ),
                // padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  icon,
                  height: 25,
                  color: iconColor,
                ),
              ),
            ),
            height5,
            Text(
              label,
              style: AppTextStyle.normalRegular10.copyWith(color: Colors.white),
            ),
          ],
        );
      },
    );
  }
}
