import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final double padding;
  final double borderRadius;
  final Color? buttonColor;
  final Color? iconColor;
  final double iconSize;
  final Widget icon;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.borderRadius = 8.0,
    this.buttonColor,
    this.iconColor,
    this.iconSize = 20.0,
    this.padding = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: Colors.white.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: buttonColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: icon,
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
  final double borderRadius;
  final double fontSize;

  const CustomTextButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.buttonColor,
    this.textColor,
    this.borderRadius = 10.0,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: height ?? 50,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          foregroundColor: textColor ?? Theme.of(context).primaryColor,
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor ?? Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final BorderRadiusGeometry borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final Gradient? gradient;

  const TransparentButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.borderColor,
    this.textColor,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      splashColor: Colors.white.withOpacity(0.2),
      child: Container(
        height: height ?? 50,
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: gradient,
          border: Border.all(
            width: 1,
            color: borderColor ?? Theme.of(context).primaryColor.withOpacity(0.5),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor ?? Theme.of(context).primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
