import 'package:socialverse/export.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? padding;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? iconColor;
  final IconData icon;
  final double? iconHeight;
  final Widget? child;
  CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.borderRadius = 0,
    this.buttonColor,
    this.iconColor,
    this.iconHeight,
    this.padding,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding ?? 14),
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: child ??
            Icon(
              icon,
              size: iconHeight ?? 18,
              color: iconColor ?? Colors.white,
            ),
      ),
    );
  }
}

class SVGButton extends StatelessWidget {
  final VoidCallback onTap;
  final double? padding;
  final double? borderRadius;
  final Color? buttonColor;
  final Color? iconColor;
  final String icon;
  final double? iconHeight;
  SVGButton(
      {Key? key,
      required this.icon,
      required this.onTap,
      this.borderRadius = 0,
      this.buttonColor,
      this.iconColor,
      this.iconHeight,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding ?? 14),
        decoration: BoxDecoration(
          color: buttonColor ?? Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: SvgPicture.asset(
          icon,
          height: iconHeight ?? 18,
          color: iconColor ?? Colors.white,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final Color? buttonColor;
  final Color? textColor;
  final double? radius;
  final double? fontSize;
  const CustomTextButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.buttonColor,
    this.radius,
    this.textColor,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor: Colors.white,
        backgroundColor: buttonColor ?? Colors.white,
        fixedSize: Size(width ?? MediaQuery.of(context).size.width, 50),
        alignment: Alignment.center,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: textColor ?? Colors.black,
          fontFamily: 'sofia',
          fontSize: fontSize ?? 16,
        ),
      ),
      onPressed: onTap,
    );
  }
}

class TransparentButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final String? image;
  final BorderRadiusGeometry? radius;
  final Color? color;
  final Color? textColor;

  const TransparentButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.image,
    this.radius,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? cs().width(context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).indicatorColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Theme.of(context).indicatorColor,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: textColor ?? Theme.of(context).primaryColor,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class CustomTransparentButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final String? image;
  final BorderRadiusGeometry? radius;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;

  const CustomTransparentButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.image,
    this.radius,
    this.color,
    this.borderColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? cs().width(context),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: borderColor ?? Theme.of(context).indicatorColor,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: textColor ?? Theme.of(context).indicatorColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
