import 'package:socialverse/export.dart';

class SubverseGridItem extends StatelessWidget {
  const SubverseGridItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.onTap,
    required this.onLongPress,
    this.hasAccess,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool? hasAccess;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Stack(
                children: [
                  CustomCachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 100,
                    width: 100,
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
                          size: 50,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Theme.of(context).focusColor),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
