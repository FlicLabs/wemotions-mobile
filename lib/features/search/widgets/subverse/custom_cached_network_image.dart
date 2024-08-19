import 'package:socialverse/export.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
  }) : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey.shade100
          // Colors.grey.shade400,
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          imageUrl: imageUrl,
          progressIndicatorBuilder: (context, url, progress) => Image.asset(
            AppAsset.load,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              AppAsset.icon,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
