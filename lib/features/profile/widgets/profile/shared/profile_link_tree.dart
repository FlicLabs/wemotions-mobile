import 'package:socialverse/export.dart';

class ProfileLinkTree extends StatelessWidget {
  const ProfileLinkTree({
    Key? key,
    required this.website,
    required this.link,
    required this.onTap,
  }) : super(key: key);

  final String website;
  final String link;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          height5,
          SizedBox(
            width: cs().width(context) / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text.rich(
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: Theme.of(context).textTheme.headlineSmall,
                        children: [
                          WidgetSpan(
                            child: Icon(
                              UniconsLine.link,
                              color: Colors.grey.shade600,
                              size: 18,
                            ),
                          ),
                          TextSpan(text: link)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
