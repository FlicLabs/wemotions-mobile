import 'package:socialverse/export.dart';

class AuthButtonWithColor extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final bool isGradient;
  final String? image;
  final BorderRadiusGeometry? radius;
  const AuthButtonWithColor({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    required this.isGradient,
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
          color: Color(0xFFE9D6FE),
            gradient: isGradient ? new LinearGradient(
                colors: [
                  Color(0xFFA858F4),
                  Color(0xFF9032E6),
                ],
                stops: [0.0, 1.0],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                tileMode: TileMode.repeated
            ) : null
        ),
        height: height ?? 59,
        width: width ?? cs().width(context),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.normalSemiBold18,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
