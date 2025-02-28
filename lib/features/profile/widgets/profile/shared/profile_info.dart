import 'package:socialverse/export.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
    required this.instagram,
    required this.tiktok,
    required this.youtube,
    required this.site,
  }) : super(key: key);

  final String instagram;
  final String tiktok;
  final String youtube;
  final String site;

  String getCount(String instagram, String tiktok, String youtube) {
    int count = 0;

    if (instagram.isNotEmpty) count++;
    if (tiktok.isNotEmpty) count++;
    if (youtube.isNotEmpty) count++;

    return count.toString();
  }

  String getLink(String count, String website) {
    if (count == '0') {
      website = website;
    } else if (count == '1') {
      website = website + '...1 other';
    } else if (count == '2') {
      website = website + '...2 others';
    } else if (count == '3') {
      website = website + '...3 others';
    }
    return website;
  }

  @override
  Widget build(BuildContext context) {
    String count = getCount(
      instagram,
      tiktok,
      youtube,
    );

    String website = getLink(count, site);

    return site.isNotEmpty
        ? ProfileLinkTree(
            website: website,
            link: website,
            onTap: () {
              if (count == '0') {
                launchUrl(Uri.parse(site));
              } else {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  builder: (context) {
                    return LinkSheetSheet(
                      instagram: instagram,
                      tiktok: tiktok,
                      website: site,
                      youtube: youtube,
                    );
                  },
                );
              }
            },
          )
        : shrink;
  }
}
