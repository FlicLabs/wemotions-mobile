import 'package:socialverse/export.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final String? image;
  final BorderRadiusGeometry? radius;
  const AuthButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.image,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? cs().width(context),
        alignment: Alignment.center,
        color: Theme.of(context).indicatorColor,
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.normalRegular16,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
