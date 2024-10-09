import 'package:socialverse/export.dart';

class ProfileStatsItem extends StatelessWidget {
  const ProfileStatsItem({
    Key? key,
    required this.value,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final int? value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$value',
            style: AppTextStyle.normalBold24.copyWith(
              color: value == 0
                  ? Theme.of(context).focusColor.withOpacity(0.5)
                  : Theme.of(context).focusColor,
            ),
          ),
          Text(
            label,
            style: AppTextStyle.normalBold14.copyWith(
              color: Theme.of(context).focusColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
