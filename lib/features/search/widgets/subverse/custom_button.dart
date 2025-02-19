import 'package:socialverse/export.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;
  const CustomButton({super.key, required this.onTap, required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          asset,
          height: 22,
          width: 22,
          color: Theme.of(context).indicatorColor,
        ),
      ),
    );
  }
}
