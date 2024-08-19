import 'package:socialverse/export.dart';

class LinkSheetSheet extends StatelessWidget {
  const LinkSheetSheet({
    Key? key,
    required this.website,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
  }) : super(key: key);

  final String website;
  final String instagram;
  final String tiktok;
  final String youtube;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (website.isNotEmpty) ...[
            LinkSheetItem(
              onTap: () {
                launchUrl(Uri.parse(website));
              },
              label: 'Website',
              link: website,
              icon: UniconsLine.link,
            ),
            height20,
          ],
          if (instagram.isNotEmpty) ...[
            LinkSheetItem(
              onTap: () {
                launchUrl(
                  Uri.parse(instagram),
                  mode: LaunchMode.externalApplication,
                );
              },
              label: 'Instagram',
              link: instagram,
              icon: UniconsLine.instagram,
            ),
            height20,
          ],
          if (tiktok.isNotEmpty) ...[
            LinkSheetItem(
              onTap: () {
                launchUrl(
                  Uri.parse(tiktok),
                  mode: LaunchMode.externalApplication,
                );
              },
              label: 'Tiktok',
              link: tiktok,
              icon: Icons.tiktok_outlined,
            ),
            height20,
          ],
          if (youtube.isNotEmpty) ...[
            LinkSheetItem(
              onTap: () {
                launchUrl(
                  Uri.parse(youtube),
                  mode: LaunchMode.externalApplication,
                );
              },
              label: 'Youtube',
              link: youtube,
              icon: UniconsLine.youtube,
            ),
          ],
          height40,
        ],
      ),
    );
  }
}
