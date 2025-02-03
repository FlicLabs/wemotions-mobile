import 'package:socialverse/export.dart';

class CustomCircularAvatar extends StatelessWidget {
  const CustomCircularAvatar({
    Key? key,
    this.imageUrl,
    this.height,
    this.width,
    this.placeholder,
    this.errorColor,
    this.borderColor,
    this.onTap,
  }) : super(key: key);

  final String? imageUrl;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Color? errorColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).hoverColor,
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 0),
            fadeOutDuration: Duration(milliseconds: 0),
            fit: BoxFit.cover,
            height: height,
            width: width,
            imageUrl: imageUrl!,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Image.asset(
              AppAsset.load,
              fit: BoxFit.cover,
              height: cs.height(context),
            ),
            errorWidget: (context, url, error) => Container(
              color: errorColor ?? Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(8),
              child: placeholder ??
                  SvgPicture.asset(
                    AppAsset.icuser,
                    color: Theme.of(context).cardColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
