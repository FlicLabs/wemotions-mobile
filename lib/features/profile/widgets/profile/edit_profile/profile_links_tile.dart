import 'package:socialverse/export.dart';

class ProfileLinkedTile extends StatelessWidget {
  final String websiteUrl;
  final String instagramUrl;
  final String tiktokUrl;
  final String youtubeUrl;

  const ProfileLinkedTile(
      {super.key,
      required this.websiteUrl,
      required this.instagramUrl,
      required this.tiktokUrl,
      required this.youtubeUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cs.width(context),
      child: Column(
        children: [
          height5,
          // if (websiteUrl != '') ...[
            Text(websiteUrl, style: AppTextStyle.subheadlineMedium),
            height10,
          // ],
          if (instagramUrl != '') ...[
            Text(instagramUrl, style: AppTextStyle.subheadlineMedium),
            height10,
          ],
          if (tiktokUrl != '') ...[
            Text(tiktokUrl, style: AppTextStyle.subheadlineMedium),
            height10,
          ],
          if (youtubeUrl != '') ...[
            Text(youtubeUrl, style: AppTextStyle.subheadlineMedium),
            height10,
          ],
        ],
      ),
    );
  }
}
