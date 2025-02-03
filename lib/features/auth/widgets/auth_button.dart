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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).indicatorColor,width: 1),
        ),
        height: height ?? 59,
        width: width ?? cs.width(context),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.normalSemiBold18Black,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
