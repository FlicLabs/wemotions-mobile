import 'package:socialverse/export.dart';

class ListPlaceholder extends StatelessWidget {
  const ListPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cs.width(context),
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40.0,
            backgroundImage: AssetImage(
              AppAsset.load,
            ),
            backgroundColor: Colors.transparent,
          ),
          width10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.load),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              height10,
              Container(
                width: 120,
                height: 10,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.load),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
