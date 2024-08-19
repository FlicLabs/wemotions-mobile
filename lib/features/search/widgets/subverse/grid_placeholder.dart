import 'package:socialverse/export.dart';

class GridPlaceholder extends StatelessWidget {
  const GridPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(AppAsset.load),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        height5,
        SizedBox(
          width: cs().width(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: 30,
              height: 8,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAsset.load),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
