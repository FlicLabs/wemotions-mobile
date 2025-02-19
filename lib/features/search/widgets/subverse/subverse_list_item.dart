import 'package:socialverse/export.dart';

class SubverseListItem extends StatelessWidget {
  const SubverseListItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.onTap,
    required this.onLongPress,
    this.description,
    this.hasAccess,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final String? description;
  final bool? hasAccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(30),
        color: Colors.transparent,
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CustomCircularAvatar(
                  imageUrl: imageUrl,
                  height: 80,
                  width: 80,
                  errorColor: Colors.grey.shade100,
                  placeholder: Image.asset(
                    AppAsset.icon,
                    color: Colors.black,
                  ),
                ),
                if (hasAccess == false)
                  Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Icon(
                        Icons.lock,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  if (description != null && description != '')
                    Text(
                      description!,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Theme.of(context).indicatorColor),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
