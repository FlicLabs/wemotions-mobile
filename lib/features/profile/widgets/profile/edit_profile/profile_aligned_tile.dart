import 'package:socialverse/export.dart';

class ProfileAlignedTile extends StatelessWidget {
  final String title;
  final String value;
  final void Function()? onTap;

  const ProfileAlignedTile({super.key, required this.title,required this.value,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: cs.width(context),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: AppTextStyle.headlineMedium
                ),
              ),
            ),
            Text(
              value,
              style:  AppTextStyle.subheadlineMedium
            ),
            width10,
            SvgPicture.asset(
              AppAsset.icForwardArrow,
              width: 24,
              height: 24,
              color: Theme.of(context).indicatorColor,
            ),
          ],
        ),
      ),
    );
  }
}
