import 'package:socialverse/export.dart';

class CameraBarItem extends StatelessWidget {
  const CameraBarItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final String icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8), // Adds subtle tap feedback
          child: Container(
            constraints: const BoxConstraints(minHeight: 40, minWidth: 40), // Better tap area
            child: SvgPicture.asset(
              icon,
              height: 25,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white, fontSize: 10),
        ),
      ],
    );
  }
}
